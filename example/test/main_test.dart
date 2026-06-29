import 'package:flutter_test/flutter_test.dart';
import 'package:x_user_agent_example/demo/demo_app.dart';

void main() {
  testWidgets('shows initial inspector call to action', (tester) async {
    await tester.pumpWidget(const DemoApp());

    expect(find.text('x_user_agent demo'), findsOneWidget);
    expect(find.text('Load inspector'), findsOneWidget);
    expect(find.text('Inspector is ready'), findsOneWidget);
  });
}
