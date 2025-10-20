import 'package:flutter_test/flutter_test.dart';
import 'package:depressive_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Темная пустота'), findsOneWidget);
  });
}