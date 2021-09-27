//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/home/home.dart';
import 'package:simas/model/model_riwayat_izin.dart';
import 'package:simas/model/model_vaksin.dart';
import 'package:simas/routes/routes.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class VaksinService {
  static String apiUrl = "http://35.211.87.216:8080/api/vaksin";
  bool isLoading = false;
  String progress;

  Dio _dio;

  VaksinService() {
    _dio = Dio();
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String> getTempPath() async {
    var dir = await getExternalStorageDirectory();
    await new Directory('${dir.path}/CompressPdfs').create(recursive: true);

    String randomString = getRandomString(10);
    String pdfFileName = '$randomString.pdf';
    return '${dir.path}/CompressPdfs/$pdfFileName';
  }

  Future<dynamic> addVaksin(
      {String namaVaksin,
      String kegunaanVaksin,
      File filePath,
      String deskripsi,
      BuildContext context}) async {
    try {
      print(namaVaksin);

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      String outputPath = await getTempPath();
      await PdfCompressor.compressPdfFile(
          filePath.path, outputPath, CompressQuality.LOW);
      String fileName = outputPath.split('/').last;
      FormData formData = new FormData.fromMap({
        "namavaksin": namaVaksin,
        "kegunaanVaksin": kegunaanVaksin,
        "picture": await MultipartFile.fromFile(outputPath,
            filename: fileName, contentType: MediaType("application", "pdf")),
        'deskripsi': deskripsi,
        "userId": id,
      });
      Response response = await _dio.post(
        apiUrl,
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
      print(response);
      print(namaVaksin);

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
      }
    }
  }
  Future<List<ModelRiwayatVaksin>> fetchRiwayatVaksin() async {
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
      ListRiwayatVaksin list =
      ListRiwayatVaksin.fromJson(response.data as List<dynamic>);
      //print(response.data);
      return list.listRiwayatVaksin;
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
  Future<List<ModelRiwayatVaksin>> fetchRiwayatVaksinByManager(int id) async {
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
      ListRiwayatVaksin list =
      ListRiwayatVaksin.fromJson(response.data as List<dynamic>);
      return list.listRiwayatVaksin;
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
