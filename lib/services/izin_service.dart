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
import 'package:simas/routes/routes.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class IzinServices {
  static String apiUrl = "http://35.211.87.216:8080/api/ijin";
  bool isLoading = false;
  String progress;

  Dio _dio;

  IzinServices() {
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

  Future<dynamic> addIzin(
      {String description,
      File filePath,
      String startTime,
      String endTime,
      BuildContext context}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      final id = _prefs.getInt('id');
      String outputPath = await getTempPath();
      await PdfCompressor.compressPdfFile(
          filePath.path, outputPath, CompressQuality.LOW);
      String fileName = outputPath.split('/').last;
      FormData formData = new FormData.fromMap({
        "picture": await MultipartFile.fromFile(outputPath,
            filename: fileName, contentType: MediaType("application", "pdf")),
        'starttime': startTime,
        "endtime": endTime,
        'description': description,
        "status": "Waiting for Approval",
        "userid": id,
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
              content: const Text(''),
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
      }
    }
  }

  Future<List<ModelRiwayatIzin>> fetchRiwayatIzin() async {
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
      ListRiwayatIzin list =
          ListRiwayatIzin.fromJson(response.data as List<dynamic>);

      return list.listRiwayatIzin;
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

  Future<List<ModelRiwayatIzin>> fetchRiwayatIzinByManager(int id) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString('token');
      //final id = _prefs.getInt('id');
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
      ListRiwayatIzin list =
          ListRiwayatIzin.fromJson(response.data as List<dynamic>);
      //print(response.data);
      return list.listRiwayatIzin;
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

  Future downloadPdf(
      {String urlPath, String fileName, BuildContext context}) async {
    final externalDir = await DownloadsPathProvider.downloadsDirectory;

    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: "Downloading File...");
    try {
      await pr.show();
      final path = externalDir.path;
      final file = File("$path/$fileName");
      await _dio.download(urlPath, file.path, onReceiveProgress: (rec, total) {
        isLoading = true;

        progress = ((rec / total) * 100).toStringAsFixed(0) + " %";
        print(progress);
        pr.update(message: "Please wait: $progress");
      });
      pr.hide();

      print(file.path);
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
              content: const Text('Jenis File Tidak Mendukung'),
              action: SnackBarAction(
                label: 'Tutup',
                onPressed: () {
                  // Code to execute.
                },
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
          throw CustomSnackBar.success(
            message: "Server sedang bermasalah",
          );
      }
    }
    isLoading = false;
  }

  Future downloadPdf2(
      {String urlPath, String fileName, BuildContext context}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString('token');
    final externalDir = await DownloadsPathProvider.downloadsDirectory;
    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: "Downloading File...");
    try {
      await pr.show();
      final path = externalDir.path;
      final file = File("$path/$fileName");
      await _dio.download(urlPath, file.path, onReceiveProgress: (rec, total) {
        isLoading = true;

        progress = ((rec / total) * 100).toStringAsFixed(0) + " %";
        print(progress);
        pr.update(message: "Please wait: $progress");
      },options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive"
          }),);
      pr.hide();

      print(file.path);
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
              content: const Text('Jenis File Tidak Mendukung'),
              action: SnackBarAction(
                label: 'Tutup',
                onPressed: () {
                  // Code to execute.
                },
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
          throw CustomSnackBar.success(
            message: "Server sedang bermasalah",
          );
      }
    }
    isLoading = false;
  }
}
