//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/home/home.dart';
import 'package:simas/routes/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simas/services/izin_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FormIzin extends StatefulWidget {
  FormIzin({Key key}) : super(key: key);

  @override
  _FormIzinState createState() => _FormIzinState();
}

class _FormIzinState extends State<FormIzin> {
  bool statusUpload = false;
  final _globalkey = GlobalKey<FormState>();
  String filename = "Upload File Bukti (.pdf)";
  String startTime;
  String endTime;
  TextEditingController descController = TextEditingController();
  File pdfFile;

  void _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      setState(() {
        pdfFile = File(file.path);
        filename = file.name;
        statusUpload = true;
      });
    } else {
      statusUpload = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.hdrDarkGrey_hex1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            backScreen(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text("Keterangan Sakit"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Form(
          key: _globalkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: RichText(
                    text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Keterangan Sakit',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DateTimeFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.event_note, color: colors.Red),
                    labelText: 'Tanggal Mulai',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Tanggal Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  onDateSelected: (DateTime value) {
                    if (value == null) {
                      return Text(
                        "Tanggal Tidak Boleh Kosong",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      startTime = value.toString();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DateTimeFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.event_note,
                      color: colors.Red,
                    ),
                    labelText: 'Tanggal Akhir',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Tanggal Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  onDateSelected: (DateTime value) {
                    if (value == null) {
                      return Text(
                        "Tanggal Tidak Boleh Kosong",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      setState(() {
                        endTime = value.toString();
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Center(
                            child: filename == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 100),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 4.0),
                                    child: Text(filename),
                                  ),
                          )),
                          Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: colors.Red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.upload_file,
                                color: colors.White,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox.expand(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(onTap: () {
                            _openFileExplorer();
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MultilineFormTextField(
                    controller: descController,
                    textHint: "Keterangan Tambahan (Opsional)",
                    textLabel: "Keterangan Tambahan (Opsional)",
                    formColor: Colors.white,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    height: 10),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: appButton(
                      btnTxt: "Ajukan",
                      onBtnclicked: () => validateAndSave(),
                      btnPadding: 15.0,
                      btnColor: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submitIzin(
      {BuildContext context,
      String startTime,
      String endTime,
      File pdfFile}) async {
    IzinServices().addIzin(
        description: descController.text,
        filePath: pdfFile,
        startTime: startTime,
        endTime: endTime,
        context: context);
    showTopSnackBar(
      context,
      Padding(
        padding: const EdgeInsets.only(top: 258.0),
        child: CustomSnackBar.success(
          message: "Pengajuan Izin Telah Terkirim",
        ),
      ),
    );
  }

  checkStatus() {
    if (statusUpload == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('File Upload tidak boleh kosong'),
        ),
      );
    } else {
      popup();
    }
  }

  void validateAndSave() {
    final FormState form = _globalkey.currentState;
    if (form.validate()) {
      checkStatus();
    } else {
      print('Form is invalid');
    }
  }

  popup() {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              backgroundColor: colors.White,
              title: Text(
                "Konfirmasi Kirim Pengajuan",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Pastikan kembali tanggal yang diajukan telah sesuai",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Batal", style: TextStyle(color: Colors.red)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: colors.btnDarkGrey_hex1)))),
                    onPressed: () => submitIzin(
                        context: context,
                        startTime: startTime,
                        endTime: endTime,
                        pdfFile: pdfFile),
                    child: Text("Kirim",
                        style: TextStyle(color: colors.btnDarkGrey_hex1)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
