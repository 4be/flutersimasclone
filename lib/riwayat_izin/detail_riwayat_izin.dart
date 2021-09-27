//@dart=2.9

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:simas/model/model_riwayat_izin.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/routes/routes.dart';
import 'package:simas/services/izin_service.dart';

class DetailRiwayatIzin extends StatefulWidget {
  final ModelRiwayatIzin modelRiwayatIjin;

  const DetailRiwayatIzin({Key key, this.modelRiwayatIjin}) : super(key: key);

  @override
  _DetailRiwayatIzinState createState() => _DetailRiwayatIzinState();
}

class _DetailRiwayatIzinState extends State<DetailRiwayatIzin> {
  String fileName;

  String date = DateTime.now().millisecondsSinceEpoch.toString();

  DateTime dateTime;
  convertDateTime(String time) {
    dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
    return DateFormat("dd MMM yyyy").format(dateTime);
  }

  @override
  void initState() {
    fileName = date +
        widget.modelRiwayatIjin.picture
            .substring(widget.modelRiwayatIjin.picture.lastIndexOf("/") + 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          padding: const EdgeInsets.only(left: 70),
          child: Text("Riwayat Sakit"),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          width: double.maxFinite,
          child: Container(
            width: width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Card(
                shadowColor: colors.Black,
                color: colors.DarkGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: width,
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Tanggal Mulai :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              convertDateTime(
                                  widget.modelRiwayatIjin.starttime),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1.5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Tanggal Akhir :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              convertDateTime(widget.modelRiwayatIjin.endtime),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1.5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "File Bukti :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 4.0),
                                            child: Text(fileName),
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
                                        child: InkWell(onTap: () async {
                                          await IzinServices().downloadPdf(
                                              context: context,
                                              urlPath: widget
                                                  .modelRiwayatIjin.picture,
                                              fileName: fileName);
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
                            Text(
                              "Keterangan Sakit :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.modelRiwayatIjin.description,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  wordSpacing: 1.5),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
