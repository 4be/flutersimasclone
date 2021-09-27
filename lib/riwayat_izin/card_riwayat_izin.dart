//@dart=2.9

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_riwayat_izin.dart';
import 'package:simas/riwayat_izin/detail_riwayat_izin.dart';
import 'package:simas/routes/routes.dart';
import '../constant/colors.dart' as colors;

class CardRiwayatIjin extends StatefulWidget {
  final ModelRiwayatIzin modelRiwayatIjin;

  CardRiwayatIjin({this.modelRiwayatIjin});

  @override
  _CardRiwayatIjinState createState() => _CardRiwayatIjinState();
}

class _CardRiwayatIjinState extends State<CardRiwayatIjin> {
  DateTime tglStartTime;

  convertTime(String time) {
    try {
      tglStartTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
      return DateFormat("dd MMM yyyy").format(tglStartTime);
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeScreen(
          context,
          DetailRiwayatIzin(
            modelRiwayatIjin: widget.modelRiwayatIjin,
          )),
      child: Container(
        height: 150,
        child: Ink(
          child: Card(
            shadowColor: colors.Black,
            color: colors.DarkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Tanggal Izin :' +
                              ' ' +
                              convertTime(widget.modelRiwayatIjin.starttime),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Keterangan Sakit : ${widget.modelRiwayatIjin.description}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
