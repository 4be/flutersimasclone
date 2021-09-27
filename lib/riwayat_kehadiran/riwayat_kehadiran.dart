import 'package:flutter/material.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/riwayat_kehadiran/list_riwayat_kehadiran_user.dart';
import 'package:simas/routes/routes.dart';

class RiwayatKehadiran extends StatefulWidget {
  const RiwayatKehadiran({Key? key}) : super(key: key);

  @override
  _RiwayatKehadiranState createState() => _RiwayatKehadiranState();
}

class _RiwayatKehadiranState extends State<RiwayatKehadiran> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.btnDarkGrey_hex2,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            color: Colors.white,
            onPressed: () {
              backScreen(context);
            },
          ),
          title: Text("Riwayat Kehadiran"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: height * 0.29,
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
                                  text: "Riwayat \nKehadiran",
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
                    height: 600,
                    width: width,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              labelColor: Colors.black,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              unselectedLabelColor: Colors.grey[400],
                              unselectedLabelStyle: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: Colors.transparent,
                              tabs: <Widget>[
                                Tab(
                                  child: Text("Clock In"),
                                ),
                                Tab(
                                  child: Text("Clock Out"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: height * 0.55,
                              child: TabBarView(
                                children: <Widget>[
                                  ListRiwayatKehadiran(status: true),
                                  ListRiwayatKehadiran(status: false),
                                ],
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
