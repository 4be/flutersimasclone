//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simas/constant/app_text_style.dart';
import 'package:simas/constant/colors.dart';
import 'colors.dart' as colors;

Widget appButton(
    {String btnTxt,
    double btnPadding,
    Color textColor,
    Color btnColor,
    VoidCallback onBtnclicked}) {
  btnTxt == null ? btnTxt == "App Button" : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  textColor == null ? textColor = Colors.white : textColor;

  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: btnColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
      onPressed: onBtnclicked,
      child: Container(
        height: 50.0,
        child: new Center(
          child: new Text(
            btnTxt,
            style: new TextStyle(color: textColor, fontSize: 18.0),
          ),
        ),
      ),
    ),
  );
}

Widget FormTextField(
    {String textLabel,
    Color focusColor,
    Color unFocusColor,
    Color formColor,
    String textHint,
    double height,
    String initVal,
    Function validator,
    TextEditingController controller,
    TextInputType textType,
    bool statusCrud}) {
  textLabel == null ? textLabel = "Enter Title" : textLabel;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;

  //height !=null

  return new Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: new TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: textType == null ? TextInputType.text : textType,
      initialValue: initVal,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.all(12),
        filled: true,
        fillColor: formColor,
        enabled: statusCrud,
        hintText: textHint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: focusColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: unFocusColor,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

Widget FormTextFieldPWD(
    {String textLabel,
    Color focusColor,
    Color unFocusColor,
    Color formColor,
    String textHint,
    double height,
    bool passwordVisible,
    VoidCallback onBtnclicked,
    TextEditingController controller,
    Function validator,
    TextInputType textType}) {
  textLabel == null ? textLabel = "Enter Title" : textLabel;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;

  return new Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: new TextFormField(
        validator: validator,
        controller: controller,
        obscureText: !passwordVisible,
        decoration: InputDecoration(
            errorStyle: TextStyle(color: colors.White),
            filled: true,
            fillColor: colors.White,
            hintText: textHint,
            prefixIcon: Icon(
              Icons.lock,
              color: colors.DarkGrey,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: colors.DarkGrey,
              ),
              onPressed: onBtnclicked,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ))),
  );
}

Widget FormTextFieldNIK(
    {String textLabel,
    Color focusColor,
    Color unFocusColor,
    Color formColor,
    String textHint,
    double height,
    TextEditingController controller,
    TextInputType textType,
    Function validator,
    FilteringTextInputFormatter filterText}) {
  textLabel == null ? textLabel = "Enter Title" : textLabel;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;

  return new Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: new TextFormField(
        validator: validator,
        controller: controller,
        maxLength: 10,
        keyboardType: textType,
        inputFormatters: <TextInputFormatter>[filterText],
        decoration: InputDecoration(
            errorStyle: TextStyle(color: colors.White),
            filled: true,
            fillColor: colors.White,
            hintText: textHint,
            counterText: "",
            prefixIcon: Icon(
              Icons.person,
              color: colors.DarkGrey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ))),
  );
}

Widget TileKshtFisik(
    {String text,
    String title,
    Function lead,
    String value,
    String groupVal,
    Function onChange}) {
  return new Column(children: [
    Text('1. Bagaimana kesehatan Fisik anda hari ini ?',
        style: AppTextStyle.light20primaryGrey()),
    ListTile(
      title: Text(text),
      leading: lead(
        value: value,
        groupValue: groupVal,
        onChanged: (value) {},
      ),
    ),
  ]);
}

Widget MultilineFormTextField(
    {String textLabel,
    String textHint,
    double height,
    Color focusColor,
    Color unFocusColor,
    Color formColor,
    TextEditingController controller,
    TextInputType textType}) {
  textLabel == null ? textLabel = "Enter Title" : textLabel;
  textHint == null ? textHint = "Enter Hint" : textHint;

  return new Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: new TextFormField(
      controller: controller,
      keyboardType: textType == null ? TextInputType.text : textType,
      maxLines: 5,
      minLines: 1,
      decoration: new InputDecoration(
        filled: true,
        fillColor: formColor,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 35.0, horizontal: 10.0),
        labelText: textLabel,
        labelStyle: TextStyle(color: colors.btnDarkGrey_hex1),
        hintText: textHint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: focusColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: unFocusColor,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

class ButtonRejectAcc extends StatelessWidget {
  ButtonRejectAcc(
      {@required this.buttonText, @required this.onPressed, this.color});
  final String buttonText;
  final Function onPressed;

  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: 50,
      margin: EdgeInsets.only(bottom: 24),
      child: FlatButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          buttonText,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
