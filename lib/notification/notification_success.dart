//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/background_image.dart';
import 'package:simas/home/home.dart';
import 'package:simas/routes/routes.dart';

class NotificationSuccess extends StatelessWidget {
  final String statusCI;
  final String day;
  final String hour;
  final String date;

  const NotificationSuccess({
    Key key,
    this.statusCI,
    this.day,
    this.hour,
    this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackgroundImage(
                image: 'assets/images/notif_success.png',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Text(
                      statusCI,
                      style: TextStyle(fontSize: 29, color: Colors.white),
                    ),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    day,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    hour,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Telah Tercatat",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        new SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25, left: 25),
                          child: appButton(
                              btnTxt: "SELESAI",
                              onBtnclicked: () => _success(context),
                              btnPadding: 20.0,
                              btnColor: Colors.red),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_success(BuildContext context) async {
  changeScreenReplacement(context, Home());
}
