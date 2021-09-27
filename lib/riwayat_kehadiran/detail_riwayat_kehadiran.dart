//@dart=2.9
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_riwayat_kehadiran.dart';
import 'package:simas/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailRiwayatKehadiran extends StatefulWidget {
  final ModelRiwayatKehadiran modelRiwayatKehadiran;

  const DetailRiwayatKehadiran({Key key, this.modelRiwayatKehadiran})
      : super(key: key);

  @override
  _DetailRiwayatKehadiranState createState() => _DetailRiwayatKehadiranState();
}

class _DetailRiwayatKehadiranState extends State<DetailRiwayatKehadiran> {
  DateTime dateTime;
  String date;
  String time;
  String day;
  String location;

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(widget.modelRiwayatKehadiran.location[0]),
          double.parse(widget.modelRiwayatKehadiran.location[1]));
      Placemark place = placemarks[0];
      setState(() {
        location =
            "${place.locality}, ${place.subLocality}, ${place.name},${place.street}, ${place.postalCode},${place.administrativeArea},${place.subAdministrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

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
    convertTime();
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.modelRiwayatKehadiran.picture,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.5),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      day,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Time : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Location : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kesehatan Fisik",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.modelRiwayatKehadiran.answer1,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kesehatan Mental",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.modelRiwayatKehadiran.answer2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Olahraga",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.modelRiwayatKehadiran.answer3,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.modelRiwayatKehadiran.description,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: height * 0.05,
                child: GestureDetector(
                  onTap: () {
                    backScreen(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 42,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
