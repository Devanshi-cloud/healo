import 'package:flutter_test/flutter_test.dart';
import 'package:calmind/main.dart';

void main() {
  testWidgets('CalMind app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalMindApp());

    // Verify the app loads with expected text
    expect(find.text('How are you feeling today?'), findsOneWidget);
  });
}
