import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qwikpass/main.dart';

void main() {
  testWidgets('App smoke test loads StubApp', (WidgetTester tester) async {
    await tester.pumpWidget(const StubApp());
    expect(find.byType(StubApp), findsOneWidget);
  });
}
