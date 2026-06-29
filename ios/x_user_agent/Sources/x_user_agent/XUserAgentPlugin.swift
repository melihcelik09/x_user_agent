import Flutter
import UIKit
import WebKit

public final class XUserAgentPlugin: NSObject, FlutterPlugin, XUserAgentApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let binaryMessenger = registrar.messenger()
    let instance = XUserAgentPlugin()
    XUserAgentApiSetup.setUp(binaryMessenger: binaryMessenger, api: instance)
    registrar.publish(instance)
  }

  func getWebViewUserAgent(completion: @escaping (Result<String?, Error>) -> Void) {
    let webView = WKWebView(frame: .zero)
    guard let userAgent = webView.value(forKey: "userAgent") as? String,
      !userAgent.isEmpty
    else {
      completion(.failure(PigeonError(
        code: "user_agent_unavailable",
        message: "WKWebView returned an empty user agent.",
        details: nil
      )))
      return
    }

    completion(.success(userAgent))
  }

  func getSystemUserAgent(completion: @escaping (Result<String?, Error>) -> Void) {
    let appName = bundleDisplayName()
    let appVersion = bundleValue(for: "CFBundleShortVersionString")
    let cfnetworkVersion = cfnetworkVersion()
    let darwinVersion = darwinVersion()

    let systemUserAgent = [
      [appName, appVersion].compactMap { $0 }.joined(separator: "/"),
      cfnetworkVersion.map { "CFNetwork/\($0)" },
      darwinVersion.map { "Darwin/\($0)" },
    ]
      .compactMap { $0 }
      .filter { !$0.isEmpty }
      .joined(separator: " ")

    if systemUserAgent.isEmpty {
      completion(.failure(PigeonError(
        code: "system_user_agent_unavailable",
        message: "Unable to construct the iOS system user agent.",
        details: nil
      )))
      return
    }

    completion(.success(systemUserAgent))
  }

  func getUserAgentData(completion: @escaping (Result<NativeUserAgentData?, Error>) -> Void) {
    var data = NativeUserAgentData()
    data.platform = UIDevice.current.systemName
    data.platformVersion = UIDevice.current.systemVersion
    data.model = UIDevice.current.model
    data.architecture = currentArchitecture()
    data.appName = bundleDisplayName()
    data.appVersion = bundleValue(for: "CFBundleShortVersionString")
    data.buildNumber = bundleValue(for: "CFBundleVersion")
    data.packageName = Bundle.main.bundleIdentifier
    data.mobile = true
    data.device = machineIdentifier()
    data.brand = "Apple"
    #if targetEnvironment(simulator)
      data.isEmulator = true
    #else
      data.isEmulator = false
    #endif
    data.darwinVersion = darwinVersion()
    data.cfnetworkVersion = cfnetworkVersion()

    completion(.success(data))
  }

  private func bundleDisplayName() -> String? {
    return bundleValue(for: "CFBundleDisplayName") ?? bundleValue(for: "CFBundleName")
  }

  private func bundleValue(for key: String) -> String? {
    return Bundle.main.object(forInfoDictionaryKey: key) as? String
  }

  private func cfnetworkVersion() -> String? {
    return Bundle(identifier: "com.apple.CFNetwork")?
      .object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }

  private func darwinVersion() -> String? {
    var systemInfo = utsname()
    uname(&systemInfo)
    return withUnsafePointer(to: &systemInfo.release.0) {
      $0.withMemoryRebound(to: CChar.self, capacity: 1) { pointer in
        String(validatingUTF8: pointer)
      }
    }
  }

  private func machineIdentifier() -> String? {
    var systemInfo = utsname()
    uname(&systemInfo)
    return withUnsafePointer(to: &systemInfo.machine.0) {
      $0.withMemoryRebound(to: CChar.self, capacity: 1) { pointer in
        String(validatingUTF8: pointer)
      }
    }
  }

  private func currentArchitecture() -> String {
    #if arch(arm64)
      return "arm64"
    #elseif arch(x86_64)
      return "x86_64"
    #elseif arch(arm)
      return "arm"
    #else
      return "unknown"
    #endif
  }
}
