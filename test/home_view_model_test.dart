import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/home/view_model/home_view_model.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([Dio])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      SharedPreferences.setMockInitialValues({"isClockIn": true});
      expect(await HomeViewModel().getClockInStatus(), true);
    });
  });
}
