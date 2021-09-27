//@dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_vaksin.dart';
import 'package:simas/riwayat_vaksin/riwayat_vaksin.dart';
import 'package:simas/riwayat_vaksin/detail_riwayat_vaksin.dart';
import 'package:simas/routes/routes.dart';
import '../../constant/colors.dart' as colors;

class CardRiwayatVaksin extends StatelessWidget {
  final ModelRiwayatVaksin modelRiwayatVaksin;
  final int index;

  CardRiwayatVaksin({this.index, this.modelRiwayatVaksin});

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
          DetailRiwayatVaksin(
            modelRiwayatVaksin: modelRiwayatVaksin,
            index: index,
          )),
      child: Container(
        height: 160,
        child: Card(
          shadowColor: colors.Black,
          color: colors.DarkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                  child: Text(
                    "Nama Vaksin : ${modelRiwayatVaksin.namaVaksin}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Text(
                    "Tanggal Upload : ${convertDateTime(modelRiwayatVaksin.createdAt)}",
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                  child: Text(
                    "Kegunaan Vaksin : ${modelRiwayatVaksin.kegunaan}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
