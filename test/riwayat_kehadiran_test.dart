import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simas/riwayat_kehadiran/riwayat_kehadiran.dart';

void main() {
  testWidgets('Check list riwayat kehadiran', (WidgetTester tester) async {
    await tester.pumpWidget(const RiwayatKehadiran());
    final listRiwayatKehadiran = find.byType(TabBarView);
    expect(listRiwayatKehadiran, findsOneWidget);
  });
}
