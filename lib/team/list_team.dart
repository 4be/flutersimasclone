//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/model/model_team.dart';
import 'package:simas/team/card_team.dart';
import 'package:simas/services/team_service.dart';

class ListTeam extends StatefulWidget {
  final ModelTeam modelTeam;

  const ListTeam({Key key, this.modelTeam}) : super(key: key);

  @override
  _ListTeamState createState() => _ListTeamState();
}

class _ListTeamState extends State<ListTeam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20),
      child: FutureBuilder<List<ModelTeam>>(
          future: TeamServices().fetchGetTeam(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox.shrink();
            } else {
              if (snapshot.data.isEmpty) {
                return Center(child: Image.asset('assets/icons/kosong.png'));
              } else {
                print(snapshot.data);
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardTeam(
                        modelTeam: data[index],
                      ),
                    );
                  },
                );
              }
            }
          }),
    );
  }
}
