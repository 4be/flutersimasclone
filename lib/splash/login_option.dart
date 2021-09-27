//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/finger_print/fingerprint.dart';
import 'package:simas/login/login.dart';
import 'package:simas/routes/routes.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/images/background.png", fit: BoxFit.fill),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), //2/6
                  Text(
                    "Login with?",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  appButton(
                      btnTxt: "Fingerprint",
                      btnColor: Colors.red,
                      onBtnclicked: () => changeScreen(context, FingerPrint())),
                  appButton(
                      btnTxt: "NIK",
                      btnColor: Colors.red,
                      onBtnclicked: () => changeScreen(context, Login())),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
