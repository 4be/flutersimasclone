import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simas/team/team.dart';

void main() {
  testWidgets('Check list anggota team', (WidgetTester tester) async {
    await tester.pumpWidget(const Team());
    final listTeam = find.byType(TabBarView);
    expect(listTeam, findsOneWidget);
  });
}
