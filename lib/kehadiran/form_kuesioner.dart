//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/kehadiran/form_kehadiran.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/app_text_style.dart';
import 'package:simas/routes/routes.dart';

class FormKuesioner extends StatefulWidget {
  final String status;
  final String currentTime;

  const FormKuesioner({Key key, this.status, this.currentTime})
      : super(key: key);

  @override
  _FormKuesionerState createState() => _FormKuesionerState();
}

enum KesehatanFisik { sangatBaik, baik, biasaSaja, tidakBaik, sangatTidakBaik }

enum KesehatanMental { sangatBaik, baik, biasaSaja, tidakBaik, sangatTidakBaik }

enum Olahraga {
  sudah,
  belum,
}

class _FormKuesionerState extends State<FormKuesioner> {
  TextEditingController descController = TextEditingController();
  TextEditingController stravaController = TextEditingController();
  String kesehatanFisik;
  String kesehatanMental;
  String olahraga;
  KesehatanFisik _kesehatanFisik;
  KesehatanMental _kesehatanMental;
  Olahraga _olahraga;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Form(
        child: ListView(
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          kesehatanFisik = "Sangat Baik";
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
                          kesehatanFisik = "Baik";
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
                          kesehatanFisik = "Biasa Saja";
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
                          kesehatanFisik = "Tidak Baik";
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
              height: 10,
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

  @override
  Widget buttonsimpan() {
    return SizedBox(
      height: 95.0,
      child: Container(
        child: Container(
          child: appButton(
              btnTxt: "Next",
              onBtnclicked: () => checkJawaban(),
              btnPadding: 20.0,
              btnColor: Colors.red),
        ),
      ),
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
      changeScreen(
          context,
          FormKehadiran(
            status: widget.status,
            answer1: kesehatanFisik,
            answer2: kesehatanMental,
            answer3: olahraga,
            currentTime: widget.currentTime,
          ));
    }
  }


}
