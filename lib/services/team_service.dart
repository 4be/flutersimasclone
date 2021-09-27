//@dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/constant/colors.dart';
import 'package:simas/home/home.dart';
import 'package:simas/model/model_team.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/splash/splash.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TeamServices {
  static String apiUrl = 'http://35.211.87.216:8080/api/users';
  //String urlLogin = apiUrl + "/login";
  String getTeamUrl = apiUrl + "/manager";
  Dio _dio;

  TeamServices() {
    _dio = Dio();
  }

  Future<List<ModelTeam>> fetchGetTeam() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final nik = _prefs.getString('nik');
      print(nik);
      Response response = await _dio.get(
        getTeamUrl + "/$nik",
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "*/*",
              "Accept-Encoding": "gzip, deflate, br",
              "Connection": "keep-alive"
            }),
      );

      ListTeam list = ListTeam.fromJson(response.data as List<dynamic>);
      return list.listTeam;
      print(response.data);
    } on DioError catch (e) {
      switch (e.response.statusCode) {
        case 400:
          throw CustomSnackBar.success(
            message: "Terjadi kesalahan pada request data",
          );
        case 401:
          throw CustomSnackBar.success(
            message: "Akses halaman terbatas (Unauthorized)",
          );
        case 404:
          throw CustomSnackBar.success(
            message: "Halaman tidak ditemukan",
          );
        case 403:
          throw CustomSnackBar.success(
            message: "Halaman tidak dapat diakses (Terlarang)",
          );
        case 500:
          throw CustomSnackBar.success(
            message: "Server sedang bermasalah",
          );
      }
    }
  }
}
