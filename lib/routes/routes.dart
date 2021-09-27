import 'package:flutter/material.dart';


void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void backScreen(BuildContext context) {
  Navigator.pop(context);
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenNamed(BuildContext context, String named) {
  Navigator.pushNamed(context, named);
}