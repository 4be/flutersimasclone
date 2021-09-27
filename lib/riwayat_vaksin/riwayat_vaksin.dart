import 'package:flutter/material.dart';
import 'package:simas/riwayat_vaksin/list_riwayat_vaksin.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/routes/routes.dart';

class RiwayatVaksin extends StatefulWidget {
  const RiwayatVaksin({Key? key}) : super(key: key);

  @override
  _RiwayatVaksinState createState() => _RiwayatVaksinState();
}

class _RiwayatVaksinState extends State<RiwayatVaksin> {
  String? _result;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
            padding: const EdgeInsets.only(left: 40),
            child: Text("Riwayat Vaksin"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: height * 0.3,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(1.0),
                            ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft)),
                      ),
                    ),
                    Positioned(
                      bottom: 90,
                      left: 20,
                      child: RichText(
                        text: TextSpan(
                            text: "Daftar ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            children: [
                              TextSpan(
                                  text: "Riwayat \nVaksin",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24))
                            ]),
                      ),
                    )
                  ],
                ),
                Transform.translate(
                  offset: Offset(0.0, -(height * 0.3 - height * 0.26)),
                  child: Container(
                    width: width,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: DefaultTabController(
                        length: 1,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 50),
                              child: Container(
                                height: 400,
                                child: TabBarView(
                                  children: <Widget>[
                                    ListRiwayatVaksin(
                                      userID: null,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
