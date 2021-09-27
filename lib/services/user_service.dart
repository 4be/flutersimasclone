//@dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/constant/colors.dart';
import 'package:simas/home/home.dart';
import 'package:simas/model/user_model.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/splash/splash.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UserServices {
  static String apiUrl = 'http://35.211.87.216:8080/api/users';
  String urlLogin = apiUrl + "/login";
  Dio _dio;

  UserServices() {
    _dio = Dio();
  }

  Future login(String nik, String password, BuildContext context) async {
    final data = {"nik": nik, "password": password};
    try {
      String token;
      int id;
      Response response = await _dio.post(urlLogin, data: data);
      token = response.data["token"];
      nik = response.data["nik"];
      id = response.data["id"];
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('token', token);
      _prefs.setString('nik', nik);
      _prefs.setInt('id', id);
      changeScreenReplacement(context, Home());
      print(token);
    } on DioError catch (e) {
      switch (e.response.statusCode) {
        case 400:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Terjadi kesalahan pada request data",
            ),
          );
        // throw ("Terjadi kesalahan pada request data");
        case 401:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Akses halaman terbatas (Unauthorized)",
            ),
          );
        case 404:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Halaman tidak ditemukan",
            ),
          );
        case 403:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Halaman tidak dapat diakses (Terlarang)",
            ),
          );
        case 500:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Server sedang bermasalah",
            ),
          );
        default:
          return showTopSnackBar(
            context,
            Padding(
              padding: const EdgeInsets.only(top: 320.0),
              child: CustomSnackBar.success(
                backgroundColor: Red,
                message: "NIK atau Password salah",
              ),
            ),
          );
      }
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      Response response = await _dio.get(
        apiUrl + "/$id",
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
      UserModel userModel = UserModel.fromJson(response.data);
      print(userModel);
      return userModel;
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

  @override
  Future<UserModel> editUser({String password, BuildContext context}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      final data = {
        "password": password,
      };
      Response response = await _dio.put(
        apiUrl + "/$id",
        data: data,
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
      print(response);
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

  @override
  Future logOut({BuildContext context}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('token');
    if (token != null) {
      await storage.remove('token');
      return changeScreenReplacement(context, Splash());
    } else {
      return ("Error LogOut");
    }
  }
}
