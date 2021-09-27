//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simas/model/user_model.dart';

Widget createDrawerHeader(UserModel userModel) {
  return DrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/cover_bg.jpeg'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 80,
              height: 80,
              child: new ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: userModel.userPicture != null
                    ? CachedNetworkImage(
                        imageUrl: userModel.userPicture,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        "assets/images/user_default.png",
                        fit: BoxFit.fill,
                      ),
              )),
          Text(
            "${userModel.firstName} ${userModel.lastName}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            userModel.email,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ));
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
