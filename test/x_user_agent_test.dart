import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:x_user_agent/src/messages.g.dart';
import 'package:x_user_agent/src/x_user_agent_platform.dart';
import 'package:x_user_agent/x_user_agent.dart';

class _MockXUserAgentApi extends Mock implements XUserAgentApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('x_user_agent', () {
    late XUserAgentApi api;

    setUp(() {
      api = _MockXUserAgentApi();
      XUserAgentPlatform.instance = XUserAgentPlatform(api: api);
    });

    group('getWebViewUserAgent', () {
      test(
        'returns correct value when platform implementation exists',
        () async {
          const userAgent = '__test_webview_user_agent__';
          when(
            () => api.getWebViewUserAgent(),
          ).thenAnswer((_) async => userAgent);

          final actualUserAgent = await getWebViewUserAgent();
          expect(actualUserAgent, equals(userAgent));
        },
      );

      test(
        'throws exception when platform implementation is missing',
        () async {
          when(() => api.getWebViewUserAgent()).thenAnswer((_) async => null);

          expect(getWebViewUserAgent, throwsException);
        },
      );
    });

    group('getSystemUserAgent', () {
      test(
        'returns correct value when platform implementation exists',
        () async {
          const userAgent = '__test_system_user_agent__';
          when(
            () => api.getSystemUserAgent(),
          ).thenAnswer((_) async => userAgent);

          final actualUserAgent = await getSystemUserAgent();
          expect(actualUserAgent, equals(userAgent));
        },
      );

      test(
        'throws exception when platform implementation is missing',
        () async {
          when(() => api.getSystemUserAgent()).thenAnswer((_) async => null);

          expect(getSystemUserAgent, throwsException);
        },
      );
    });

    group('getUserAgentData', () {
      test('returns structured user agent data', () async {
        final userAgentData = NativeUserAgentData(
          platform: 'Android',
          platformVersion: '15',
          model: 'Pixel',
          architecture: 'arm64-v8a',
          appName: 'Example',
          appVersion: '1.0.0',
          buildNumber: '1',
          packageName: 'com.steel.xuseragent.example',
          mobile: true,
          brand: 'Google',
          device: 'tokay',
          isEmulator: false,
        );
        when(
          () => api.getUserAgentData(),
        ).thenAnswer((_) async => userAgentData);

        final actualUserAgentData = await getUserAgentData();
        expect(
          actualUserAgentData,
          equals(
            const XUserAgentData(
              platform: 'Android',
              platformVersion: '15',
              model: 'Pixel',
              architecture: 'arm64-v8a',
              appName: 'Example',
              appVersion: '1.0.0',
              buildNumber: '1',
              packageName: 'com.steel.xuseragent.example',
              mobile: true,
              brand: 'Google',
              device: 'tokay',
              isEmulator: false,
            ),
          ),
        );
      });

      test(
        'throws exception when structured user agent data is missing',
        () async {
          when(() => api.getUserAgentData()).thenAnswer((_) async => null);

          expect(getUserAgentData, throwsException);
        },
      );
    });

    test(
      'getClientHintsHeaders maps structured data into client hints headers',
      () async {
        final userAgentData = NativeUserAgentData(
          platform: 'Android',
          platformVersion: '15',
          model: 'Pixel',
          architecture: 'arm64-v8a',
          appName: 'Example',
          appVersion: '1.0.0',
          buildNumber: '1',
          packageName: 'com.steel.xuseragent.example',
          mobile: true,
        );
        when(
          () => api.getUserAgentData(),
        ).thenAnswer((_) async => userAgentData);

        final headers = await getClientHintsHeaders();
        expect(headers['Sec-CH-UA-Platform'], '"Android"');
        expect(headers['Sec-CH-UA-Platform-Version'], '"15"');
        expect(headers['Sec-CH-UA-Mobile'], '?1');
        expect(headers['Sec-CH-UA-Model'], '"Pixel"');
        expect(headers['Sec-CH-UA-Arch'], '"arm64-v8a"');
        expect(headers.containsKey('Sec-CH-UA'), isFalse);
      },
    );
  });
}
