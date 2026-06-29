# x_user_agent

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter plugin for inspecting mobile user-agent data on Android and iOS.

## Usage

```dart
final webViewUserAgent = await getWebViewUserAgent();
final systemUserAgent = await getSystemUserAgent();
final userAgentData = await getUserAgentData();
final clientHintsHeaders = await getClientHintsHeaders();
```

## Example app

The bundled example app shows the plugin output in a small demo inspector UI.

Run it from the `example` directory:

```bash
flutter run
```

Current example structure:

```text
example/lib/
├── main.dart
└── demo/
    ├── demo_app.dart
    ├── demo_page.dart
    └── widgets/
        ├── hero_card.dart
        ├── key_value_list.dart
        ├── section_card.dart
        ├── state_cards.dart
        └── summary_row.dart
```

## `XUserAgentData` fields

| Field              | Type      | Notes                                            |
| ------------------ | --------- | ------------------------------------------------ |
| `platform`         | `String?` | OS name such as `Android` or `iOS`.              |
| `platformVersion`  | `String?` | OS version string.                               |
| `model`            | `String?` | Device model.                                    |
| `architecture`     | `String?` | CPU architecture when available.                 |
| `appName`          | `String?` | App display name.                                |
| `appVersion`       | `String?` | App semantic version.                            |
| `buildNumber`      | `String?` | App build number.                                |
| `packageName`      | `String?` | Android package name or iOS bundle identifier.   |
| `mobile`           | `bool?`   | Whether the device is mobile.                    |
| `device`           | `String?` | Lower-level device identifier.                   |
| `brand`            | `String?` | Device manufacturer or brand.                    |
| `isEmulator`       | `bool?`   | `true` on emulator or simulator when detectable. |
| `darwinVersion`    | `String?` | Darwin kernel version on iOS when available.     |
| `cfnetworkVersion` | `String?` | CFNetwork version on iOS when available.         |

All fields are nullable. Missing values are omitted rather than filled with placeholders.

## `getClientHintsHeaders()` example

`getClientHintsHeaders()` returns a conservative subset derived from local device data.

```dart
final headers = await getClientHintsHeaders();

print(headers);
```

Example output:

```dart
{
  'Sec-CH-UA-Platform': '"Android"',
  'Sec-CH-UA-Platform-Version': '"14"',
  'Sec-CH-UA-Mobile': '?1',
  'Sec-CH-UA-Model': '"Pixel 8"',
  'Sec-CH-UA-Arch': '"arm64-v8a"',
}
```

## Example user agents

| System  | User-Agent                                                                       | WebView User-Agent                                                                                                                                                   |
| ------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS     | `CFNetwork/897.15 Darwin/17.5.0 (iPhone/6s iOS/11.3)`                            | `Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E217`                                                      |
| Android | `Dalvik/2.1.0 (Linux; U; Android 5.1.1; Android SDK built for x86 Build/LMY48X)` | `Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36` |

These are representative examples. Actual values vary by OS version, device model, WebView version, and runtime environment.

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core
[very_good_ventures_link_dark]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-light-mode-only
