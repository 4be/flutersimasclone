//@dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_riwayat_kehadiran.dart';
import 'package:simas/riwayat_kehadiran/detail_riwayat_kehadiran.dart';
import 'package:simas/routes/routes.dart';
import '../constant/colors.dart' as colors;
import 'package:cached_network_image/cached_network_image.dart';

class CardRiwayatKehadiran extends StatefulWidget {
  final ModelRiwayatKehadiran modelRiwayatKehadiran;

  CardRiwayatKehadiran({this.modelRiwayatKehadiran});

  @override
  _CardRiwayatKehadiranState createState() => _CardRiwayatKehadiranState();
}

class _CardRiwayatKehadiranState extends State<CardRiwayatKehadiran> {
  DateTime dateTime;
  String date;
  String time;
  String day;

  convertTime() {
    if (widget.modelRiwayatKehadiran.time != "") {
      dateTime = DateFormat("EEE MMM dd HH:mm:ss 'WIB' yyyy")
          .parse(widget.modelRiwayatKehadiran.time);
      date = DateFormat("dd MMM yyyy").format(dateTime);
      time = DateFormat("HH:mm").format(dateTime);
      day = DateFormat("EEEE").format(dateTime);
    } else {
      date = "-";
      time = "-";
      day = "-";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    convertTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeScreen(
          context,
          DetailRiwayatKehadiran(
            modelRiwayatKehadiran: widget.modelRiwayatKehadiran,
          )),
      child: Container(
        height: 130,
        child: Ink(
          child: Card(
            shadowColor: colors.Black,
            color: colors.DarkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 33,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: widget.modelRiwayatKehadiran.picture,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 30),
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 66,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          day, //harinya (senin)
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          date, //tanggal (21 ju;y 2021)
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          "Time : " + time, //jam (07.00)
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
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
