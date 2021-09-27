//@dart=2.9

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_riwayat_kesehatan.dart';
import 'package:simas/riwayat_kesehatan/detail_riwayat_kesehatan.dart';
import 'package:simas/routes/routes.dart';
import '../constant/colors.dart' as colors;

class CardRiwayatKesehatan extends StatelessWidget {
  final ModelRiwayatKesehatan modelRiwayatKesehatan;

  CardRiwayatKesehatan({this.modelRiwayatKesehatan, int index});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    convertDateTime(String time) {
      dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time);
      return DateFormat("dd MMM yyyy").format(dateTime);
    }

    return GestureDetector(
      onTap: () => changeScreen(
          context,
          DetailRiwayatKesehatan(
            modelRiwayatKesehatan: modelRiwayatKesehatan,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Tanggal : ${convertDateTime(modelRiwayatKesehatan.createdAt)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Kesehatan Fisik : ${modelRiwayatKesehatan.kondisiFisik}'
                            ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Kesehatan Mental : ${modelRiwayatKesehatan.kondisiMental}',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
