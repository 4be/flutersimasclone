//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:simas/home/home.dart';
import 'package:simas/routes/routes.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({Key key}) : super(key: key);

  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  LocalAuthentication auth = LocalAuthentication();
  bool checkBio = false;
  bool isBioFinger = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBiometrics();
    listBioAndFindFingerType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/images/background.png", fit: BoxFit.fill),
          SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    startAuth();
                  },
                  icon: Icon(
                    Icons.fingerprint,
                    size: 50,
                  ),
                  iconSize: 60,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void checkBiometrics() async {
    try {
      final bio = await auth.canCheckBiometrics;
      setState(() {
        checkBio = bio;
      });
      print("biometrics=$checkBio");
    } catch (e) {}
  }

  void listBioAndFindFingerType() async {
    List<BiometricType> listType;
    try {
      listType = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e.message);
    }
    print("list biometrics=$listType");
    if (listType.contains(BiometricType.fingerprint)) {
      setState(() {
        isBioFinger = true;
      });
      print("fingerprint is $isBioFinger");
    }
  }

  void startAuth() async {
    bool isAuthenticated = false;
    AndroidAuthMessages androidAuthMessages = AndroidAuthMessages(
      signInTitle: "",
      biometricHint: "",
      cancelButton: "",
    );
    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: "Scan Your Finger Print",
        useErrorDialogs: true,
        stickyAuth: true,
        // androidAuthStrings: null,
        // iOSAuthStrings: null,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (isAuthenticated) {
      changeScreenReplacement(context, Home());
    }
  }
}
