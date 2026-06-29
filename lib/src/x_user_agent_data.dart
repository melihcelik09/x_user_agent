import 'package:flutter/foundation.dart';

/// Structured mobile user-agent metadata.
@immutable
class XUserAgentData {
  /// Creates structured user-agent metadata.
  const XUserAgentData({
    this.platform,
    this.platformVersion,
    this.model,
    this.architecture,
    this.appName,
    this.appVersion,
    this.buildNumber,
    this.packageName,
    this.mobile,
    this.device,
    this.brand,
    this.isEmulator,
    this.darwinVersion,
    this.cfnetworkVersion,
  });

  /// Creates structured metadata from a map.
  factory XUserAgentData.fromMap(Map<Object?, Object?> map) {
    return XUserAgentData(
      platform: map['platform'] as String?,
      platformVersion: map['platformVersion'] as String?,
      model: map['model'] as String?,
      architecture: map['architecture'] as String?,
      appName: map['appName'] as String?,
      appVersion: map['appVersion'] as String?,
      buildNumber: map['buildNumber'] as String?,
      packageName: map['packageName'] as String?,
      mobile: map['mobile'] as bool?,
      device: map['device'] as String?,
      brand: map['brand'] as String?,
      isEmulator: map['isEmulator'] as bool?,
      darwinVersion: map['darwinVersion'] as String?,
      cfnetworkVersion: map['cfnetworkVersion'] as String?,
    );
  }

  /// The operating system name.
  final String? platform;

  /// The operating system version.
  final String? platformVersion;

  /// The device model name.
  final String? model;

  /// The device CPU architecture.
  final String? architecture;

  /// The app display name.
  final String? appName;

  /// The app semantic version.
  final String? appVersion;

  /// The app build number.
  final String? buildNumber;

  /// The app package or bundle identifier.
  final String? packageName;

  /// Whether the device is mobile.
  final bool? mobile;

  /// A lower-level device identifier.
  final String? device;

  /// The device manufacturer or brand.
  final String? brand;

  /// Whether the app is running on an emulator or simulator.
  final bool? isEmulator;

  /// The Darwin kernel version, when available.
  final String? darwinVersion;

  /// The CFNetwork version, when available.
  final String? cfnetworkVersion;

  /// Converts the model to a serializable map.
  Map<String, Object?> toMap() {
    return <String, Object?>{
      'platform': platform,
      'platformVersion': platformVersion,
      'model': model,
      'architecture': architecture,
      'appName': appName,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'packageName': packageName,
      'mobile': mobile,
      'device': device,
      'brand': brand,
      'isEmulator': isEmulator,
      'darwinVersion': darwinVersion,
      'cfnetworkVersion': cfnetworkVersion,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is XUserAgentData &&
            runtimeType == other.runtimeType &&
            platform == other.platform &&
            platformVersion == other.platformVersion &&
            model == other.model &&
            architecture == other.architecture &&
            appName == other.appName &&
            appVersion == other.appVersion &&
            buildNumber == other.buildNumber &&
            packageName == other.packageName &&
            mobile == other.mobile &&
            device == other.device &&
            brand == other.brand &&
            isEmulator == other.isEmulator &&
            darwinVersion == other.darwinVersion &&
            cfnetworkVersion == other.cfnetworkVersion;
  }

  @override
  int get hashCode => Object.hash(
    platform,
    platformVersion,
    model,
    architecture,
    appName,
    appVersion,
    buildNumber,
    packageName,
    mobile,
    device,
    brand,
    isEmulator,
    darwinVersion,
    cfnetworkVersion,
  );
}
