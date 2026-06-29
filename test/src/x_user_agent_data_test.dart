import 'package:flutter_test/flutter_test.dart';
import 'package:x_user_agent/x_user_agent.dart';

void main() {
  test('XUserAgentData serializes and deserializes values', () {
    const data = XUserAgentData(
      platform: 'iOS',
      platformVersion: '18.0',
      model: 'iPhone',
      architecture: 'arm64',
      appName: 'Example',
      appVersion: '1.0.0',
      buildNumber: '1',
      packageName: 'com.steel.xuseragent.example',
      mobile: true,
      device: 'iPhone16,2',
      brand: 'Apple',
      isEmulator: false,
      darwinVersion: '24.0.0',
      cfnetworkVersion: '1498.700.2',
    );

    final actual = XUserAgentData.fromMap(data.toMap());

    expect(actual, equals(data));
  });
}
