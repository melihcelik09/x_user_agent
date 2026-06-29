import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartPackageName: 'x_user_agent',
    kotlinOut: 'android/src/main/kotlin/com/steel/xuseragent/Messages.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/x_user_agent/Sources/x_user_agent/Messages.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
class NativeUserAgentData {
  String? platform;
  String? platformVersion;
  String? model;
  String? architecture;
  String? appName;
  String? appVersion;
  String? buildNumber;
  String? packageName;
  bool? mobile;
  String? device;
  String? brand;
  bool? isEmulator;
  String? darwinVersion;
  String? cfnetworkVersion;
}

@HostApi()
abstract class XUserAgentApi {
  @async
  String? getWebViewUserAgent();

  @async
  String? getSystemUserAgent();

  @async
  NativeUserAgentData? getUserAgentData();
}
