import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example app loads', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    expect(find.text('HOME'), findsOneWidget);
  });
}
