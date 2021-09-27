//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/home/home.dart';
import 'package:simas/model/model_riwayat_kesehatan.dart';
import 'package:simas/routes/routes.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class KesehatanServices {
  static String apiUrl = "http://35.211.87.216:8080/api/kesehatan";

  Dio _dio;

  KesehatanServices() {
    _dio = Dio();
  }

  Future addKesehatan(
      {int userId,
      String description,
      String kondisiFisik,
      String kondisiMental,
      String statusOlahraga,
      int suhuTubuh,
      bool vaksinasi,
      int beratBadan,
      String linkStrava,
      BuildContext context}) async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      final id = storage.getInt('id');
      final token = storage.getString('token');
      final data = {
        "beratBadan": 1,
        "suhuTubuh": 2,
        "kondisiFisik": kondisiFisik,
        "kondisiMental": kondisiMental,
        "statusOlahraga": statusOlahraga,
        "deskripsi": description,
        "vaksin": vaksinasi,
        "userid": id,
        "linkstrava": linkStrava,
      };
      Response response = await _dio.post(
        apiUrl,
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
      return changeScreenReplacement(context, Home());
    } on DioError catch (e) {
      switch (e.response.statusCode) {
        case 400:
          return showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Terjadi kesalahan pada request data",
            ),
          );
        case 401:
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('NIK atau Password salah'),
              action: SnackBarAction(
                label: 'Tutup',
                onPressed: () {},
              ),
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
          throw ("Server sedang bermasalah");
        default:
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('NIK atau Password salah'),
            ),
          );
      }
    }
  }

  Future<List<ModelRiwayatKesehatan>> fetchKesehatan() async {
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
      ListRiwayatKesehatan list =
          ListRiwayatKesehatan.fromJson(response.data as List<dynamic>);
      //print(response.data);
      return list.listRiwayatKesehatan;
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

  Future<List<ModelRiwayatKesehatan>> fetchKesehatanByManager(int id) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
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
      ListRiwayatKesehatan list =
          ListRiwayatKesehatan.fromJson(response.data as List<dynamic>);
      return list.listRiwayatKesehatan;
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
}
