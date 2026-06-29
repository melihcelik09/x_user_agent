import 'package:flutter/material.dart';
import 'package:x_user_agent/x_user_agent.dart';
import 'package:x_user_agent_example/demo/widgets/hero_card.dart';
import 'package:x_user_agent_example/demo/widgets/key_value_list.dart';
import 'package:x_user_agent_example/demo/widgets/section_card.dart';
import 'package:x_user_agent_example/demo/widgets/state_cards.dart';
import 'package:x_user_agent_example/demo/widgets/summary_row.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String? _webViewUserAgent;
  String? _systemUserAgent;
  XUserAgentData? _userAgentData;
  Map<String, String>? _clientHintsHeaders;
  bool _isLoading = false;
  String? _errorMessage;

  bool get _hasData =>
      _webViewUserAgent != null &&
      _systemUserAgent != null &&
      _userAgentData != null &&
      _clientHintsHeaders != null;

  Future<void> _loadInspector() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait<Object>([
        getWebViewUserAgent(),
        getSystemUserAgent(),
        getUserAgentData(),
        getClientHintsHeaders(),
      ]);

      if (!mounted) return;
      setState(() {
        _webViewUserAgent = results[0] as String;
        _systemUserAgent = results[1] as String;
        _userAgentData = results[2] as XUserAgentData;
        _clientHintsHeaders = results[3] as Map<String, String>;
      });
    } on Exception catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.85),
              colorScheme.surface,
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth >= 720
                  ? 32.0
                  : 20.0;

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      24,
                      horizontalPadding,
                      32,
                    ),
                    children: [
                      HeroCard(
                        isLoading: _isLoading,
                        hasData: _hasData,
                        onPressed: _isLoading ? null : _loadInspector,
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null) ...[
                        ErrorCard(message: _errorMessage!),
                        const SizedBox(height: 20),
                      ],
                      if (_isLoading && !_hasData) ...[
                        const LoadingCard(),
                      ] else if (_hasData) ...[
                        SummaryRow(userAgentData: _userAgentData!),
                        const SizedBox(height: 20),
                        SectionCard(
                          title: 'WebView User Agent',
                          subtitle: 'Embedded web runtime string',
                          child: SelectableText(
                            _webViewUserAgent!,
                            key: const Key('webview_user_agent_value'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'System User Agent',
                          subtitle: 'Native networking stack string',
                          child: SelectableText(
                            _systemUserAgent!,
                            key: const Key('system_user_agent_value'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'User Agent Data',
                          subtitle: 'Structured fields returned by the plugin',
                          child: KeyValueList(entries: _userAgentData!.toMap()),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'Client Hints Headers',
                          subtitle: 'Request headers derived from device data',
                          child: KeyValueList(entries: _clientHintsHeaders!),
                        ),
                      ] else ...[
                        const EmptyStateCard(),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
