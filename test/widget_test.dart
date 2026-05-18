import 'package:desktop_clock_mobile/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app renders clock and calendar', (tester) async {
    await tester.pumpWidget(const DesktopClockApp());
    expect(find.byType(DesktopClockApp), findsOneWidget);
  });
}
