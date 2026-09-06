# x_user_agent

<p align="center">
  <a href="https://pub.dev/packages/x_user_agent"><img src="https://img.shields.io/pub/v/x_user_agent.svg?style=flat-square" alt="Pub Version"></a>
  <a href="https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors"><img src="https://img.shields.io/badge/SPM-Ready-orange.svg?style=flat-square&logo=swift" alt="Swift Package Manager Ready"></a>
  <a href="https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors"><img src="https://img.shields.io/badge/Built--in%20Kotlin-AGP%209%2B-blue.svg?style=flat-square&logo=kotlin" alt="Built-in Kotlin Support"></a>
  <a href="https://pub.dev/packages/very_good_analysis"><img src="https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square" alt="style: very good analysis"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square" alt="License: MIT"></a>
  <img src="coverage_badge.svg" alt="Coverage">
</p>

<p align="center">
  <b>A modern, high-performance Flutter plugin for inspecting WebView and System User-Agent headers, structured device telemetry, and RFC Client Hints on Android and iOS.</b>
</p>

---

## ✨ Features

- 🍎 **SPM Ready & CocoaPods Compatible** — Fully configured with Swift Package Manager (SPM) for modern Flutter 3.44+ iOS builds while maintaining full CocoaPods backward compatibility.
- 🤖 **Built-in Kotlin (AGP 9+ Ready)** — Follows the latest Flutter Android toolchain guidelines with built-in Kotlin compilation, eliminating deprecated Kotlin Gradle Plugin (KGP) application conflicts.
- 🕊️ **Type-Safe Native IPC** — Powered by [Pigeon](https://pub.dev/packages/pigeon) for lightning-fast, zero-overhead, strictly-typed native platform communication.
- 🌐 **WebView & System User-Agents** — Retrieve the real WebKit/Chromium WebView user-agent and native OS/HTTP network stack user-agents independently.
- 📊 **Structured Device Metadata (`XUserAgentData`)** — Access parsed device architecture, OS version, app details, emulator detection, and Darwin/CFNetwork versions.
- 🛡️ **RFC Client Hints Support** — Automatically construct standard `Sec-CH-UA-*` headers for modern HTTP client telemetry and anti-fraud pipelines.

---

## 🚀 Getting Started

### Installation

Add `x_user_agent` to your `pubspec.yaml`:

```bash
flutter pub add x_user_agent
```

Or manually:

```yaml
dependencies:
  x_user_agent: ^1.1.0
```

### Platform Requirements

| Platform | Minimum Version | Build System Support |
| :--- | :--- | :--- |
| **Android** | API 19 (Android 4.4+) | **Built-in Kotlin** (AGP 8.x / 9.x+), Gradle |
| **iOS** | iOS 13.0+ | **Swift Package Manager (SPM)** & CocoaPods |

---

## 💡 Usage

Import the package:

```dart
import 'package:x_user_agent/x_user_agent.dart';
```

### 1. Fetching User Agents

```dart
// 1. Get WebView User-Agent (WebKit on iOS, Chrome/Chromium on Android)
final String? webViewUA = await getWebViewUserAgent();
print('WebView User-Agent: $webViewUA');

// 2. Get System / Native HTTP User-Agent
final String? systemUA = await getSystemUserAgent();
print('System User-Agent: $systemUA');
```

### 2. Inspecting Structured Device Metadata

Retrieve structured device details with null-safe fallbacks:

```dart
final XUserAgentData? data = await getUserAgentData();

if (data != null) {
  print('Platform: ${data.platform} ${data.platformVersion}');
  print('Device: ${data.brand} ${data.model} (${data.architecture})');
  print('App: ${data.appName} v${data.appVersion} (${data.buildNumber})');
  print('Is Emulator: ${data.isEmulator}');
  
  if (data.platform == 'iOS') {
    print('Darwin Version: ${data.darwinVersion}');
    print('CFNetwork Version: ${data.cfnetworkVersion}');
  }
}
```

### 3. Generating HTTP Client Hints Headers

Easily attach standard [User-Agent Client Hints](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sec-CH-UA) to your HTTP client requests (e.g. `dio`, `http`):

```dart
import 'package:http/http.dart' as http;
import 'package:x_user_agent/x_user_agent.dart';

Future<void> sendRequest() async {
  final clientHints = await getClientHintsHeaders();

  final response = await http.get(
    Uri.parse('https://api.example.com/data'),
    headers: {
      ...clientHints,
      'Accept': 'application/json',
    },
  );
}
```

**Example Generated Headers:**

```json
{
  "Sec-CH-UA-Platform": "\"Android\"",
  "Sec-CH-UA-Platform-Version": "\"14\"",
  "Sec-CH-UA-Mobile": "?1",
  "Sec-CH-UA-Model": "\"Pixel 8\"",
  "Sec-CH-UA-Arch": "\"arm64-v8a\""
}
```

---

## 📋 `XUserAgentData` Properties

| Property | Type | Platform | Description |
| :--- | :--- | :--- | :--- |
| `platform` | `String?` | Android / iOS | Operating system name (e.g. `Android`, `iOS`). |
| `platformVersion` | `String?` | Android / iOS | OS version release string (e.g. `14`, `17.4`). |
| `model` | `String?` | Android / iOS | Hardware model name (e.g. `Pixel 8`, `iPhone14,2`). |
| `architecture` | `String?` | Android / iOS | CPU architecture (e.g. `arm64-v8a`, `arm64`, `x86_64`). |
| `appName` | `String?` | Android / iOS | Display application label. |
| `appVersion` | `String?` | Android / iOS | Semantic app version from package metadata. |
| `buildNumber` | `String?` | Android / iOS | Application build/version code. |
| `packageName` | `String?` | Android / iOS | Android package ID or iOS bundle identifier. |
| `mobile` | `bool?` | Android / iOS | `true` if running on a mobile device form factor. |
| `device` | `String?` | Android / iOS | Low-level hardware identifier string. |
| `brand` | `String?` | Android / iOS | Device manufacturer or brand (e.g. `Google`, `Apple`). |
| `isEmulator` | `bool?` | Android / iOS | `true` when running on a simulator or emulator. |
| `darwinVersion` | `String?` | iOS | Kernel Darwin release version (e.g. `23.4.0`). |
| `cfnetworkVersion` | `String?` | iOS | CFNetwork framework build version. |

---

## 🔬 Sample User-Agent Outputs

| OS | System User-Agent | WebView User-Agent |
| :--- | :--- | :--- |
| **iOS** | `CFNetwork/1494.0.7 Darwin/23.4.0 (iPhone14,2 iOS/17.4)` | `Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148` |
| **Android** | `Dalvik/2.1.0 (Linux; U; Android 14; Pixel 8 Build/UQ1A.240205.004)` | `Mozilla/5.0 (Linux; Android 14; Pixel 8 Build/UQ1A.240205.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.64 Mobile Safari/537.36` |

---

## 📱 Example Project

A complete demo application is available in the [`example`](./example) directory showcasing live inspector cards, copy-to-clipboard actions, and client hints testing.

To run the example app:

```bash
cd example
flutter run
```

---

## 🧪 Testing

Run unit tests and verify coverage:

```bash
flutter test --coverage
```

Analyze code quality:

```bash
flutter analyze
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
