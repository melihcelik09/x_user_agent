import 'package:x_user_agent/src/x_user_agent_data.dart';
import 'package:x_user_agent/src/x_user_agent_platform.dart';
export 'package:x_user_agent/src/x_user_agent_data.dart' show XUserAgentData;

XUserAgentPlatform get _platform => XUserAgentPlatform.instance;

/// Returns the current WebView user agent.
Future<String> getWebViewUserAgent() async {
  final userAgent = await _platform.getWebViewUserAgent();
  if (userAgent == null) throw Exception('Unable to get user agent.');
  return userAgent;
}

/// Returns the current system user agent.
Future<String> getSystemUserAgent() async {
  final userAgent = await _platform.getSystemUserAgent();
  if (userAgent == null) throw Exception('Unable to get system user agent.');
  return userAgent;
}

/// Returns structured user-agent metadata.
Future<XUserAgentData> getUserAgentData() async {
  final userAgentData = await _platform.getUserAgentData();
  if (userAgentData == null) {
    throw Exception('Unable to get structured user agent data.');
  }
  return userAgentData;
}

/// Returns a conservative subset of `Sec-CH-*` headers derived from local data.
Future<Map<String, String>> getClientHintsHeaders() async {
  final data = await getUserAgentData();
  final headers = <String, String>{};

  if (data.platform != null && data.platform!.isNotEmpty) {
    headers['Sec-CH-UA-Platform'] = '"${data.platform!}"';
  }
  if (data.platformVersion != null && data.platformVersion!.isNotEmpty) {
    headers['Sec-CH-UA-Platform-Version'] = '"${data.platformVersion!}"';
  }
  if (data.mobile != null) {
    headers['Sec-CH-UA-Mobile'] = data.mobile! ? '?1' : '?0';
  }
  if (data.model != null && data.model!.isNotEmpty) {
    headers['Sec-CH-UA-Model'] = '"${data.model!}"';
  }
  if (data.architecture != null && data.architecture!.isNotEmpty) {
    headers['Sec-CH-UA-Arch'] = '"${data.architecture!}"';
  }

  return headers;
}
