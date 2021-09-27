//@dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simas/model/model_team.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/team/list_data_team.dart';
import '../constant/colors.dart' as colors;

class CardTeam extends StatelessWidget {
  final ModelTeam modelTeam;

  CardTeam({this.modelTeam});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeScreen(
          context,
          ListDataTeam(
            userID: modelTeam.id,
            name: "${modelTeam.firstname} ${modelTeam.lastname}",
          )),
      child: Container(
        height: 130,
        child: Ink(
          child: Card(
            shadowColor: colors.Black,
            color: colors.DarkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 33,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: modelTeam.picture,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 30),
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Nama : ${modelTeam.firstname} ${modelTeam.lastname}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                          child: Text(
                            'NIK : ' + modelTeam.nik.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Divisi  :' + ' ' + modelTeam.divisi.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
