//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/constant/app_text_style.dart';
import 'package:simas/services/kesehatan_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckUp extends StatefulWidget {
  @override
  _CheckUpState createState() => _CheckUpState();
}

enum KesehatanFisik { sangatBaik, baik, biasaSaja, tidakBaik, sangatTidakBaik }

enum KesehatanMental { sangatBaik, baik, biasaSaja, tidakBaik, sangatTidakBaik }

enum Olahraga {
  sudah,
  belum,
}

class _CheckUpState extends State<CheckUp> {
  TextEditingController descController = TextEditingController();
  TextEditingController stravaController = TextEditingController();
  KesehatanFisik _kesehatanFisik;
  KesehatanMental _kesehatanMental;
  Olahraga _olahraga;
  String kesehatanFisik;
  String kesehatanMental;
  String olahraga;
  String _url = 'https://www.strava.com/';

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, enableJavaScript: true, forceSafariVC: true);
    } else {
      print('Could not launch $url');
    }
  }

  // void _launchURL() async => await canLaunch(_url)
  //     ? await launch(_url)
  //     : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Text('1. Bagaimana kesehatan Fisik anda hari ini ?',
                      style: AppTextStyle.light20primaryGrey()),
                  ListTile(
                    title: Text('Sangat Baik'),
                    leading: Radio<KesehatanFisik>(
                      value: KesehatanFisik.sangatBaik,
                      groupValue: _kesehatanFisik,
                      onChanged: (KesehatanFisik value) {
                        setState(() {
                          _kesehatanFisik = value;
                          kesehatanFisik = 'Sangat Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Baik'),
                    leading: Radio<KesehatanFisik>(
                      value: KesehatanFisik.baik,
                      groupValue: _kesehatanFisik,
                      onChanged: (KesehatanFisik value) {
                        setState(() {
                          _kesehatanFisik = value;
                          kesehatanFisik = 'Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Biasa Saja'),
                    leading: Radio<KesehatanFisik>(
                      value: KesehatanFisik.biasaSaja,
                      groupValue: _kesehatanFisik,
                      onChanged: (KesehatanFisik value) {
                        setState(() {
                          _kesehatanFisik = value;
                          kesehatanFisik = 'Biasa Saja';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Tidak Baik'),
                    leading: Radio<KesehatanFisik>(
                      value: KesehatanFisik.tidakBaik,
                      groupValue: _kesehatanFisik,
                      onChanged: (KesehatanFisik value) {
                        setState(() {
                          _kesehatanFisik = value;
                          kesehatanFisik = 'Tidak Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Sangat Tidak Baik'),
                    leading: Radio<KesehatanFisik>(
                      value: KesehatanFisik.sangatTidakBaik,
                      groupValue: _kesehatanFisik,
                      onChanged: (KesehatanFisik value) {
                        setState(() {
                          _kesehatanFisik = value;
                          kesehatanFisik = 'Sangat Tidak Baik';
                        });
                      },
                    ),
                  ),
                ],
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
              child: Column(
                children: [
                  Text('2. Bagaimana kesehatan Mental anda hari ini ?',
                      style: AppTextStyle.light20primaryGrey()),
                  ListTile(
                    title: Text('Sangat Baik'),
                    leading: Radio<KesehatanMental>(
                      value: KesehatanMental.sangatBaik,
                      groupValue: _kesehatanMental,
                      onChanged: (KesehatanMental value) {
                        setState(() {
                          _kesehatanMental = value;
                          kesehatanMental = 'Sangat Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Baik'),
                    leading: Radio<KesehatanMental>(
                      value: KesehatanMental.baik,
                      groupValue: _kesehatanMental,
                      onChanged: (KesehatanMental value) {
                        setState(() {
                          _kesehatanMental = value;
                          kesehatanMental = 'Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Biasa Saja'),
                    leading: Radio<KesehatanMental>(
                      value: KesehatanMental.biasaSaja,
                      groupValue: _kesehatanMental,
                      onChanged: (KesehatanMental value) {
                        setState(() {
                          _kesehatanMental = value;
                          kesehatanMental = 'Biasa Saja';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Tidak Baik'),
                    leading: Radio<KesehatanMental>(
                      value: KesehatanMental.tidakBaik,
                      groupValue: _kesehatanMental,
                      onChanged: (KesehatanMental value) {
                        setState(() {
                          _kesehatanMental = value;
                          kesehatanMental = 'Tidak Baik';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Sangat Tidak Baik'),
                    leading: Radio<KesehatanMental>(
                      value: KesehatanMental.sangatTidakBaik,
                      groupValue: _kesehatanMental,
                      onChanged: (KesehatanMental value) {
                        setState(() {
                          _kesehatanMental = value;
                          kesehatanMental = 'Sangat Tidak Baik';
                        });
                      },
                    ),
                  ),
                ],
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
              child: Column(
                children: [
                  Text('3. Apakah anda sudah berolahraga hari ini ?',
                      style: AppTextStyle.light20primaryGrey()),
                  ListTile(
                    title: Text('Sudah'),
                    leading: Radio<Olahraga>(
                      value: Olahraga.sudah,
                      groupValue: _olahraga,
                      onChanged: (Olahraga value) {
                        setState(() {
                          _olahraga = value;
                          olahraga = 'Sudah';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Belum'),
                    leading: Radio<Olahraga>(
                      value: Olahraga.belum,
                      groupValue: _olahraga,
                      onChanged: (Olahraga value) {
                        setState(() {
                          _olahraga = value;
                          olahraga = 'Belum';
                        });
                      },
                    ),
                  ),
                ],
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
                controller: stravaController,
                textLabel: "Link Strava",
                textHint: "Masukan url aktifitas strava anda",
                focusColor: Colors.orange,
                unFocusColor: colors.DarkGrey,
                formColor: colors.btnSoftGrey,
                statusCrud: true,
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
                controller: descController,
                textLabel: "Deskripsi Kesehatan",
                textHint: "Deskripsikan Kondisi Anda... (Opsional)",
                focusColor: Colors.orange,
                unFocusColor: colors.DarkGrey,
                formColor: colors.btnSoftGrey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
              ),
              child: buttonStrava(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: buttonsimpan(),
            ),
          ],
        ),
      ),
    );
  }

  addKesehatan(BuildContext context) {
    KesehatanServices().addKesehatan(
      context: context,
      linkStrava: stravaController.text,
      kondisiFisik: kesehatanFisik,
      kondisiMental: kesehatanMental,
      statusOlahraga: olahraga,
      description: descController.text,
      vaksinasi: true,
    );
  }

  @override
  Widget buttonsimpan() {
    return SizedBox(
      height: 95.0,
      child: Container(
        child: Container(
          child: appButton(
              btnTxt: "Simpan",
              onBtnclicked: () => checkJawaban(),
              btnPadding: 20.0,
              btnColor: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget buttonStrava() {
    return SizedBox(
      height: 95.0,
      child: appButton(
          btnTxt: "Hubungkan Strava",
          onBtnclicked: () => openUrl(_url),
          btnPadding: 20.0,
          btnColor: colors.btnDarkGrey_hex1),
    );
  }

  checkJawaban() {
    if (_kesehatanFisik == null ||
        _kesehatanMental == null ||
        _olahraga == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Jawaban Questioner tidak boleh dikosongkan'),
        ),
      );
    } else {
      popup();
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
                "Konfirmasi Informasi Kesehatan",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Pastikan data yang dimasukan telah sesuai sebelum dikirim",
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
                    onPressed: () => addKesehatan(context),
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
