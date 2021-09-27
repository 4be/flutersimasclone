//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/model/model_riwayat_kehadiran.dart';
import 'package:simas/model/user_model.dart';
import 'package:simas/notification/notification_success.dart';
import 'package:simas/riwayat_kehadiran/riwayat_kehadiran.dart';
import 'package:simas/routes/routes.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class KehadiranServices {
  static String apiUrl = "http://35.211.87.216:8080/api/absen";
  String clockInUrl = apiUrl + "/clockin";
  String clockOutUrl = apiUrl + "/clockout";
  String getClockInUrl = apiUrl + "/search/clockin";
  String getClockOutUrl = apiUrl + "/search/clockout";

  Dio _dio;

  KehadiranServices() {
    _dio = Dio();
  }

  Future<dynamic> clockIn(
      {String location,
      String description,
      File filePath,
      bool status,
      BuildContext context,
      String day,
      String hour,
      String date,
      String answer1,
      String answer2,
      String answer3,
      String time}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');

      String fileName = filePath.path.split('/').last;
      FormData formData = new FormData.fromMap({
        "picture": await MultipartFile.fromFile(filePath.path,
            filename: fileName, contentType: MediaType("image", "png")),
        'location': location,
        'description': description,
        "status": true,
        "userid": id,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "time": time
      });
      Response response = await _dio.post(
        clockInUrl,
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              "Authorization": "Bearer $token",
              'Content-Type': "multipart/form-data",
              "Accept": "*/*",
              "Accept-Encoding": "gzip, deflate, br",
              "Connection": "keep-alive"
            }),
      );
      _prefs.setBool('isClockIn', true);
      changeScreenReplacement(
          context,
          NotificationSuccess(
            statusCI: "Clock In",
            date: date,
            day: day,
            hour: hour,
          ));
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

  Future<dynamic> clockOut(
      {BuildContext context,
      String location,
      String description,
      File filePath,
      bool status,
      String day,
      String hour,
      String date,
      String answer1,
      String answer2,
      String answer3,
      String time}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      String fileName = filePath.path.split('/').last;
      FormData formData = new FormData.fromMap({
        "picture": await MultipartFile.fromFile(filePath.path,
            filename: fileName, contentType: MediaType("image", "png")),
        'location': location,
        'description': description,
        "status": false,
        "userid": id,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "time": time
      });
      Response response = await _dio.post(
        clockOutUrl,
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              "Authorization": "Bearer $token",
              'Content-Type': "multipart/form-data",
              "Accept": "*/*",
              "Accept-Encoding": "gzip, deflate, br",
              "Connection": "keep-alive"
            }),
      );
      _prefs.setBool('isClockIn', false);

      changeScreenReplacement(
          context,
          NotificationSuccess(
            statusCI: "Clock Out",
            date: date,
            day: day,
            hour: hour,
          ));
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

  Future<List<ModelRiwayatKehadiran>> fetchRiwayatClockIn() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      print("ini$id");
      Response response = await _dio.get(
        getClockInUrl + "/$id",
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
      ListRiwayatKehadiran list =
          ListRiwayatKehadiran.fromJson(response.data as List<dynamic>);
      //print(response.data);
      return list.listRiwayatKehadiran;
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

  Future<List<ModelRiwayatKehadiran>> fetchRiwayatClockOut() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      Response response = await _dio.get(
        getClockOutUrl + "/$id",
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
      ListRiwayatKehadiran list =
          ListRiwayatKehadiran.fromJson(response.data as List<dynamic>);
      //print(response.data);
      return list.listRiwayatKehadiran;
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

  Future<List<ModelRiwayatKehadiran>> fetchRiwayatClockInByManager(
      int id) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');

      print("ini$id");
      Response response = await _dio.get(
        getClockInUrl + "/$id",
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
      ListRiwayatKehadiran list =
          ListRiwayatKehadiran.fromJson(response.data as List<dynamic>);

      return list.listRiwayatKehadiran;
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

  Future<List<ModelRiwayatKehadiran>> fetchRiwayatClockOutByManager(
      int id) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');

      Response response = await _dio.get(
        getClockOutUrl + "/$id",
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
      ListRiwayatKehadiran list =
          ListRiwayatKehadiran.fromJson(response.data as List<dynamic>);
      return list.listRiwayatKehadiran;
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
