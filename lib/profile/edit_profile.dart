//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/home/home.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/services/user_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:simas/model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;

  EditProfile({Key key, this.userModel}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool error = false;
  bool _passwordVisible = false;

  void visiblePWd() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  bool circular = false;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _passOld = TextEditingController();
  final TextEditingController _passNew = TextEditingController();
  final TextEditingController _confirmPassNew = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.hdrDarkGrey_hex1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            backScreen(context);
          },
        ),
        actions: [
          new Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 270, 0),
              child: Text(
                'Kembali',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
              imageProfile(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                    statusCrud: false,
                    textLabel: 'NIK',
                    initVal: widget.userModel.nik,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.grey[350]),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                    statusCrud: false,
                    textLabel: 'First Name',
                    initVal: widget.userModel.firstName,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.grey[350]),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                    statusCrud: false,
                    textLabel: 'Last Name',
                    initVal: widget.userModel.lastName,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.grey[350]),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                    statusCrud: false,
                    textLabel: 'Email',
                    initVal: widget.userModel.email,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.grey[350]),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: FormTextFieldPWD(
                    textLabel: 'Password Lama',
                    textHint: "Password Lama",
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.white,
                    controller: _passOld,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        this.error = true;
                        return "Password tidak boleh dikosongkan";
                      }
                    },
                    onBtnclicked: () => visiblePWd(),
                    passwordVisible: _passwordVisible,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextFieldPWD(
                  textLabel: 'Password Baru',
                  textHint: "Password Baru",
                  focusColor: Colors.orange,
                  unFocusColor: Colors.white,
                  formColor: Colors.white,
                  controller: _passNew,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      this.error = true;
                      return "Password baru tidak boleh dikosongkan";
                    }
                  },
                  onBtnclicked: () => visiblePWd(),
                  passwordVisible: _passwordVisible,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextFieldPWD(
                  textLabel: 'Konfirmasi Password Baru',
                  textHint: "Konfirmasi Password Baru",
                  focusColor: Colors.orange,
                  unFocusColor: Colors.white,
                  formColor: Colors.white,
                  controller: _confirmPassNew,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      this.error = true;
                      return "Konfirmasi Password tidak boleh dikosongkan";
                    }
                    if (value != _passNew.text) {
                      return "Konfirmasi Password tidak sama dengan Password Baru";
                    }
                  },
                  onBtnclicked: () => visiblePWd(),
                  passwordVisible: _passwordVisible,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                    statusCrud: false,
                    textLabel: "Divisi",
                    initVal: widget.userModel.division,
                    focusColor: Colors.orange,
                    unFocusColor: Colors.white,
                    formColor: Colors.grey[350]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: buttonsimpan()),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 100, right: 100),
      child: Container(
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(150)),
          // width: 10,
          // height: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: widget.userModel.userPicture != null
                  ? CachedNetworkImage(
                      imageUrl: widget.userModel.userPicture,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      "assets/images/user_default.png",
                      fit: BoxFit.fill,
                    ))),
    );
  }

  @override
  Widget buttonsimpan() {
    return SizedBox(
      height: 95.0,
      child: appButton(
          btnTxt: "Simpan",
          onBtnclicked: () => validateAndSave(),
          btnPadding: 20.0,
          btnColor: Colors.red),
    );
  }

  submitEdit({
    BuildContext context,
    String password,
  }) async {
    UserServices().editUser(password: password, context: context);
    Navigator.pop(context);
    showTopSnackBar(
      context,
      Padding(
        padding: const EdgeInsets.only(top: 258.0),
        child: CustomSnackBar.success(
          message: "Password Telah Diperbarui",
        ),
      ),
    );
    backScreen(context);
  }

  void validateAndSave() {
    final FormState form = _key.currentState;
    if (form.validate()) {
      popup();
    } else {
      print('Form is invalid');
    }
  }

  popup() {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              backgroundColor: colors.White,
              title: Text(
                "Konfirmasi Perubahan Password",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Password lama akan digantikan dengan yang baru, lanjutkan perubahan ?",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Batal", style: TextStyle(color: Colors.red)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: colors.btnDarkGrey_hex1),
                        ),
                      ),
                    ),
                    onPressed: () => submitEdit(
                      context: context,
                      password: _passNew.text,
                    ),
                    child: Text("Ya, Ubah",
                        style: TextStyle(color: colors.btnDarkGrey_hex1)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
