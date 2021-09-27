//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/user_model.dart';
import 'package:simas/services/user_service.dart';
import '../constant/app_text_style.dart';

class HomeImage extends StatefulWidget {
  const HomeImage({Key key}) : super(key: key);

  @override
  _HomeImageState createState() => _HomeImageState();
}

class _HomeImageState extends State<HomeImage> {
  String date = DateFormat("dd MMM yyyy").format(DateTime.now());
  String hours = DateFormat("HH:mm").format(DateTime.now());
  String day = DateFormat("EEEE").format(DateTime.now());
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserServices().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userModel = snapshot.data;
            return Container(
                child: Stack(
              children: <Widget>[
                Container(
                    child: new Column(
                  children: [
                    new Container(
                      child: Image.asset('assets/images/cover_bg.jpeg',
                          height: 180, width: 450, fit: BoxFit.fill),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 100, top: 2, bottom: 10),
                      child: new Container(
                        child: userModel.id == null
                            ? Text('ID : Null')
                            : Text("ID : ${userModel.id}"),
                      ),
                    ),
                  ],
                )),
                Positioned(
                  top: 120,
                  left: 30,
                  child: Container(
                      width: 80,
                      height: 80,
                      child: new ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: userModel.userPicture != null
                            ? CachedNetworkImage(
                                imageUrl: userModel.userPicture,
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                "assets/images/user_default.png",
                                fit: BoxFit.fill,
                              ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120, 150, 0, 12),
                  child: new Container(
                    child: userModel.firstName != null
                        ? Text(
                            "${userModel.firstName} ${userModel.lastName}",
                            style: AppTextStyle.medium80PrimaryWhite(),
                          )
                        : Text(
                            "Null",
                            style: AppTextStyle.medium80PrimaryWhite(),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 30),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        Text(day,
                            style: AppTextStyle.medium60PrimaryWhite(),
                            textAlign: TextAlign.right),
                        Text(date,
                            style: AppTextStyle.light40primaryWhite(),
                            textAlign: TextAlign.right),
                        Text(hours,
                            style: AppTextStyle.light40primaryWhite(),
                            textAlign: TextAlign.right),
                      ],
                    ),
                  ),
                )
              ],
            ));
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
