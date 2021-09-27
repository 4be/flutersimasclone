//@dart=2.9
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/services/vaksin_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:io';

class FormVaksin extends StatefulWidget {
  @override
  _FormVaksinState createState() => _FormVaksinState();
}

class _FormVaksinState extends State<FormVaksin> {
  bool statusUpload = false;
  final _key = GlobalKey<FormState>();
  String filename = "Upload File Vaksinisasi (.pdf)";
  File pdfFile;
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController namaVaksinController = TextEditingController();
  TextEditingController kegunaanVaksinController = TextEditingController();

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
    return Container(
      child: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: FormTextField(
                controller: namaVaksinController,
                statusCrud: true,
                textLabel: "Nama Vaksin",
                textHint: "Nama vaksin yang diterima",
                focusColor: Colors.orange,
                unFocusColor: colors.DarkGrey,
                formColor: colors.btnSoftGrey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama Vaksin tidak boleh dikosongkan";
                  }
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: FormTextField(
                controller: kegunaanVaksinController,
                statusCrud: true,
                textLabel: "Kegunaan Vaksin",
                textHint: "Kegunaan Vaksin",
                focusColor: Colors.orange,
                unFocusColor: colors.DarkGrey,
                formColor: colors.btnSoftGrey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kegunaan Vaksin tidak boleh dikosongkan";
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
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.Red, width: 5),
                          ),
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
                          ),
                        )),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: colors.Red,
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
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: MultilineFormTextField(
                controller: deskripsiController,
                textLabel: "Deskripsi Vaksinisasi",
                textHint: "Deskripsikan Pengalaman Vaksinisasi anda (Opsional)",
                focusColor: Colors.orange,
                unFocusColor: colors.DarkGrey,
                formColor: colors.btnSoftGrey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: SizedBox(
                height: 95.0,
                child: Container(
                  child: Container(
                    child: appButton(
                        btnTxt: "Simpan",
                        onBtnclicked: () => validateAndSave(),
                        btnPadding: 20.0,
                        btnColor: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkStatus() {
    if (statusUpload == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('File Vaksinasi tidak boleh kosong'),
        ),
      );
    } else {
      popup();
    }
  }

  void validateAndSave() {
    final FormState form = _key.currentState;
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
                "Konfirmasi Penambahan Vaksinasi",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Pastikan data yang dimasukan telah sesuai",
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
                    onPressed: () => submitVaksin(
                        context: context,
                        namaVaksin: namaVaksinController.text,
                        kegunaanVaksin: kegunaanVaksinController.text,
                        deskripsi: deskripsiController.text,
                        pdfFile: pdfFile),
                    child: Text("Ya, Kirim",
                        style: TextStyle(color: colors.btnDarkGrey_hex1)),
                  ),
                ),
              ],
            ),
          );
        });
  }

  submitVaksin(
      {BuildContext context,
      String namaVaksin,
      String kegunaanVaksin,
      String deskripsi,
      File pdfFile}) async {
    VaksinService().addVaksin(
        namaVaksin: namaVaksin,
        kegunaanVaksin: kegunaanVaksin,
        deskripsi: deskripsi,
        filePath: pdfFile,
        context: context);
    print(namaVaksin);
    print(kegunaanVaksin);
    print(deskripsi);
    print(pdfFile);

    showTopSnackBar(
      context,
      Padding(
        padding: const EdgeInsets.only(top: 258.0),
        child: CustomSnackBar.success(
          message: "Form Vaksinasi Tersimpan",
        ),
      ),
    );
  }
}
