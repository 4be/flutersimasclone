//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/background_image.dart';
import 'package:simas/services/user_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // void _askPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     Permission.storage,
  //     Permission.camera,
  //
  //   ].request();
  //   print(statuses[Permission.location]);
  //   print(statuses[Permission.storage]);
  //   print(statuses[Permission.camera]);
  //   var statusCamera = await Permission.camera.status;
  //   if (statusCamera.isDenied) {
  //     Permission.camera;
  //   }
  //   var statusStorage = await Permission.storage.status;
  //   if (statusStorage.isDenied) {
  //     Permission.storage;
  //   }
  //   var statusLocation = await Permission.location.status;
  //   if (statusLocation.isDenied) {
  //     Permission.location;
  //   }
  // }
  TextEditingController nikController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool error = false;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool loading = false;
  void visiblePWd() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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
                image: 'assets/images/background.png',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: new Image.asset("assets/images/logo_sinarmas.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "H C M S",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "PT Bank Sinarmas",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: FormTextFieldNIK(
                              controller: nikController,
                              textLabel: 'Nomor NIK',
                              textHint: "Masukkan Nomor NIK",
                              formColor: Colors.white,
                              focusColor: Colors.orange,
                              unFocusColor: Colors.white,
                              textType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  this.error = true;
                                  return "Kolom NIK dan Password tidak boleh dikosongkan";
                                } else if (value.length < 10) {
                                  this.error = true;
                                  return "NIK terdiri 10 digit angka";
                                }
                                return null;
                              },
                              filterText:
                                  FilteringTextInputFormatter.digitsOnly,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: FormTextFieldPWD(
                                controller: pwdController,
                                textLabel: 'Password',
                                textHint: "Masukkan Password",
                                formColor: Colors.white,
                                focusColor: Colors.orange,
                                unFocusColor: Colors.white,
                                onBtnclicked: () => visiblePWd(),
                                passwordVisible: _passwordVisible,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    this.error = true;
                                    return "Kolom password tidak boleh dikosongkan";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          appButton(
                              btnTxt: "Login",
                              onBtnclicked: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  await login(context, nikController.text,
                                      pwdController.text);
                                  error = false;
                                } else {
                                  if (error == true) {}
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              btnPadding: 20.0,
                              btnColor: Colors.red),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: loading,
                child: Padding(
                  padding: const EdgeInsets.only(top: 500),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 6,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

login(BuildContext context, String nik, String password) async {
  await UserServices().login(nik, password, context);
}
