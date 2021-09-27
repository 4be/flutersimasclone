//@dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/colors.dart';
import 'package:simas/home/home.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/notification/notification_success.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:simas/services/kehadiran_service.dart';
import '../constant/colors.dart' as colors;

class FormKehadiran extends StatefulWidget {
  final String status;
  final String currentTime;
  final String answer1;
  final String answer2;
  final String answer3;

  const FormKehadiran(
      {Key key,
      this.status,
      this.currentTime,
      this.answer1,
      this.answer2,
      this.answer3})
      : super(key: key);

  @override
  _FormKehadiranState createState() => _FormKehadiranState();
}

class _FormKehadiranState extends State<FormKehadiran> {
  Position _currentPosition;
  String _currentAddress;
  String _currentLocation;
  DateTime tgl;
  String date;
  String hours;
  String day;

  convertTime() {
    tgl =
        DateFormat("EEE MMM dd HH:mm:ss 'WIB' yyyy").parse(widget.currentTime);
    date = DateFormat("dd MMM yyyy").format(tgl);
    hours = DateFormat("HH:mm").format(tgl);
    day = DateFormat("EEEE").format(tgl);
  }

  TextEditingController descController = TextEditingController();
  File imageFile;
  final picker = ImagePicker();
  bool loading = false;
  bool loading2 = false;
  bool klik = true;

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 10,
    );

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    convertTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.btnDarkGrey_hex2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          color: Colors.white,
          onPressed: () {
            changeScreen(context, Home());
          },
        ),
        title: Text("Clock In"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Stack(
                        children: [
                          Container(
                              child: imageFile != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 55.0),
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(imageFile),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: 300,
                                      child: Image.asset(
                                          'assets/images/ambil_foto.png'),
                                    )),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 180.0, top: 140.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 50.0,
                                    child: FlatButton(
                                      shape: CircleBorder(
                                          side:
                                              BorderSide(color: Colors.white)),
                                      color: colors.btnRed_hex1,
                                      child: Icon(Icons.camera_alt,
                                          color: Colors.white),
                                      onPressed: () {
                                        chooseImage(ImageSource.camera);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 100.0, bottom: 8),
                          child: Column(
                            children: [
                              RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: widget.status,
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 22,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Time : ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white)),
                                    new TextSpan(
                                        text: hours,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Tanggal : ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white)),
                                    new TextSpan(
                                        text: date,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 8.0,
                                spreadRadius: 2.0)
                          ]),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 50.0,
                                height: 80.0,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: colors.btnDarkGrey_hex2,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: colors.LightGrey,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 4.0),
                                  child: _currentAddress == null
                                      ? Visibility(
                                          visible: klik,
                                          child: Text(
                                              "Klik untuk temukan lokasi",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      color: colors
                                                          .btnDarkGrey_hex1)),
                                        )
                                      : Text(_currentAddress),
                                ),
                              )),
                            ],
                          ),
                          SizedBox.expand(
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(onTap: () async {
                                await _determinePosition();
                              }),
                            ),
                          ),
                          Visibility(
                            visible: loading,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                                strokeWidth: 4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MultilineFormTextField(
                        controller: descController,
                        textHint: "(Opsional)",
                        textLabel: "Keterangan Tambahan (Opsional)",
                        formColor: Colors.white,
                        focusColor: Colors.orange,
                        unFocusColor: Colors.white,
                        height: 10),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 20),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: appButton(
                            btnTxt: widget.status,
                            onBtnclicked: () {
                              setState(() {
                                loading2 = true;
                              });
                              if (imageFile != null &&
                                  _currentPosition != null) {
                                widget.status == "Clock In"
                                    ? clockIn(
                                        context: context,
                                        date: date,
                                        day: day,
                                        hour: hours)
                                    : clockOut(
                                        context: context,
                                        date: date,
                                        day: day,
                                        hour: hours);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Photo Selfie atau Lokasi belum diisi'),
                                  ),
                                );
                              }
                            },
                            btnPadding: 8.0,
                            btnColor: Colors.red),
                      ),
                    ),
                    Visibility(
                      visible: loading2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red),
                            strokeWidth: 6,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentLocation =
            "${_currentPosition.latitude},${_currentPosition.longitude}";
        _currentAddress =
            "${place.locality}, ${place.subLocality}, ${place.name},${place.street}, ${place.postalCode},${place.administrativeArea},${place.subAdministrativeArea}, ${place.country}";
        loading = false;
        klik = true;
      });
    } catch (e) {
      print(e);
    }
  }

  _determinePosition() async {
    setState(() {
      loading = true;
      klik = false;
    });
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getCurrentLocation();
  }

  clockIn({BuildContext context, String day, String hour, String date}) async {
    KehadiranServices().clockIn(
        status: true,
        description: descController.text,
        filePath: imageFile,
        location: _currentLocation.toString(),
        day: day,
        date: date,
        hour: hour,
        context: context,
        answer1: widget.answer1,
        answer2: widget.answer2,
        answer3: widget.answer3,
        time: widget.currentTime);
  }

  clockOut({BuildContext context, String day, String hour, String date}) {
    KehadiranServices().clockOut(
        context: context,
        status: true,
        description: descController.text,
        filePath: imageFile,
        location: _currentLocation.toString(),
        day: day,
        hour: hour,
        date: date,
        answer1: widget.answer1,
        answer2: widget.answer2,
        answer3: widget.answer3,
        time: widget.currentTime);
  }
}
