//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simas/login/login.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(Login());
    // Create the Finders.
    final titleFinder = find.text('H C M S');
    final namebankfind = find.text('PT Bank Sinarmas');
    final labeltextnik = find.text('Nomor NIK');
    final texthintnik = find.text('Masukkan Nomor NIK');
    final notiferror1 =
        find.text('Kolom NIK dan Password tidak boleh dikosongkan');
    final notiferror2 = find.text('NIK terdiri 10 digit angka');
    final labeltextpas = find.text('Password');
    final texthintpass = find.text('Masukkan Password');
    final notiferror1pass = find.text('Kolom password tidak boleh dikosongkan');
    final textbtn = find.text('Login');

    expect(titleFinder, findsOneWidget);
    expect(namebankfind, findsOneWidget);
    expect(labeltextnik, findsOneWidget);
    expect(texthintnik, findsOneWidget);
    expect(notiferror1, findsOneWidget);
    expect(notiferror2, findsOneWidget);
    expect(labeltextpas, findsOneWidget);
    expect(texthintpass, findsOneWidget);
    expect(notiferror1pass, findsOneWidget);
    expect(textbtn, findsOneWidget);
  });
}
