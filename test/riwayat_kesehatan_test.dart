import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simas/riwayat_kesehatan/riwayat_kesehatan.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const RiwayatKesehatan());
    final container = find.byType(Container);
    expect(container, findsOneWidget);
  });
}
