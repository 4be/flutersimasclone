//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/riwayat_izin/list_riwayat_izin.dart';
import 'package:simas/riwayat_kehadiran/list_riwayat_kehadiran_manager.dart';
import 'package:simas/riwayat_kesehatan/list_riwayat_kesehatan.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/riwayat_vaksin/list_riwayat_vaksin.dart';
import 'package:simas/routes/routes.dart';

class ListDataTeam extends StatefulWidget {
  final int userID;
  final String name;

  const ListDataTeam({Key key, this.userID, this.name}) : super(key: key);

  @override
  _ListDataTeamState createState() => _ListDataTeamState();
}

class _ListDataTeamState extends State<ListDataTeam> {
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
            child: Text("Riwayat Kesehatan"),
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
                            text: "Data\n",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                            children: [
                              TextSpan(
                                  text: widget.name,
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
                        length: 5,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              isScrollable: true,
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
                                  child: Text("Kesehatan"),
                                ),
                                Tab(
                                  child: Text("Clock In"),
                                ),
                                Tab(
                                  child: Text("Clock Out"),
                                ),
                                Tab(
                                  child: Text("Vaksin"),
                                ),
                                Tab(
                                  child: Text("Izin"),
                                ),
                              ],
                            ),
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
                                    ListRiwayatKesehatan(
                                      userID: widget.userID,
                                    ),
                                    ListRiwayatKehadiranManager(
                                      status: true,
                                      id: widget.userID,
                                    ),
                                    ListRiwayatKehadiranManager(
                                      status: false,
                                      id: widget.userID,
                                    ),
                                    ListRiwayatVaksin(
                                      userID: widget.userID,
                                    ),
                                    ListRiwayatIzin(
                                      userID: widget.userID,
                                    )
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
