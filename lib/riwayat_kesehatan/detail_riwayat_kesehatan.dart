//@dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_riwayat_kesehatan.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/routes/routes.dart';

class DetailRiwayatKesehatan extends StatefulWidget {
  final ModelRiwayatKesehatan modelRiwayatKesehatan;

  const DetailRiwayatKesehatan({Key key, this.modelRiwayatKesehatan})
      : super(key: key);

  @override
  _DetailRiwayatKesehatanState createState() => _DetailRiwayatKesehatanState();
}

class _DetailRiwayatKesehatanState extends State<DetailRiwayatKesehatan> {
  DateTime dateTime;

  convertDateTime(String time) {
    dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time);
    return DateFormat("dd MMMM yyyy").format(dateTime);
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
          padding: const EdgeInsets.only(left: 20),
          child: Text("Riwayat Kesehatan"),
        ),
      ),
      body: Container(
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
                            height: 10,
                          ),
                          Text(
                            "Tanggal : ${convertDateTime(widget.modelRiwayatKesehatan.createdAt)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Kesehatan Fisik :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.modelRiwayatKesehatan.kondisiFisik,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                wordSpacing: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Kesehatan Mental :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.modelRiwayatKesehatan.kondisiMental,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                wordSpacing: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Status Olahraga :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.modelRiwayatKesehatan.statusOlahraga,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                wordSpacing: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Link Strava :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.modelRiwayatKesehatan.linkStrava,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                wordSpacing: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Deskripsi Kesehatan :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.modelRiwayatKesehatan.deskripsi,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
