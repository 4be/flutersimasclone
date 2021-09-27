//@dart=2.9
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  final String title;
  final String image;
  final dynamic color;
  VoidCallback onBtnclicked;

  HomeMenu({this.title, this.image, this.color, this.onBtnclicked});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onBtnclicked,
      child: Container(
        width: (screenWidth - 80) / 2,
        height: (screenWidth - 100) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(color),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Image(image: AssetImage(image)),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}

class HomeMenu2 extends StatelessWidget {
  final String title;
  final String image;
  final dynamic color;
  VoidCallback onBtnclicked;

  HomeMenu2({this.title, this.image, this.color, this.onBtnclicked});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onBtnclicked,
      child: Container(
        width: (screenWidth - 55) / 1,
        height: (screenWidth - 100) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(color),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            child: Image(image: AssetImage(image)),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}
