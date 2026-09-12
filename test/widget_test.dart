import 'package:flutter_test/flutter_test.dart';

import 'package:headcare_app/main.dart';

void main() {
  testWidgets('App renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HeadCareApp());
    expect(find.text('HeadCare'), findsOneWidget);

    // Advance past the splash screen timer (3 seconds)
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
