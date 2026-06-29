import 'package:flutter/foundation.dart';
import 'package:x_user_agent/src/messages.g.dart';
import 'package:x_user_agent/src/x_user_agent_data.dart';

/// Internal host API bridge for the single-package plugin.
class XUserAgentPlatform {
  /// Creates a platform bridge backed by the generated Pigeon API.
  XUserAgentPlatform({
    @visibleForTesting XUserAgentApi? api,
  }) : _api = api ?? XUserAgentApi();

  /// The active platform bridge instance used by the public API helpers.
  static XUserAgentPlatform instance = XUserAgentPlatform();

  final XUserAgentApi _api;

  /// Returns the current WebView user agent from the host platform.
  Future<String?> getWebViewUserAgent() {
    return _api.getWebViewUserAgent();
  }

  /// Returns the current system user agent from the host platform.
  Future<String?> getSystemUserAgent() {
    return _api.getSystemUserAgent();
  }

  /// Returns structured user-agent metadata from the host platform.
  Future<XUserAgentData?> getUserAgentData() async {
    final data = await _api.getUserAgentData();
    if (data == null) return null;

    return XUserAgentData(
      platform: data.platform,
      platformVersion: data.platformVersion,
      model: data.model,
      architecture: data.architecture,
      appName: data.appName,
      appVersion: data.appVersion,
      buildNumber: data.buildNumber,
      packageName: data.packageName,
      mobile: data.mobile,
      device: data.device,
      brand: data.brand,
      isEmulator: data.isEmulator,
      darwinVersion: data.darwinVersion,
      cfnetworkVersion: data.cfnetworkVersion,
    );
  }
}
