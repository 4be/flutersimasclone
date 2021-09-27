//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/model/model_vaksin.dart';
import 'package:simas/riwayat_vaksin/card_riwayat_vaksin.dart';
import 'package:simas/services/vaksin_service.dart';

class ListRiwayatVaksin extends StatefulWidget {
  final int userID;

  const ListRiwayatVaksin({Key key, this.userID}) : super(key: key);

  @override
  _ListRiwayatVaksinState createState() => _ListRiwayatVaksinState();
}

class _ListRiwayatVaksinState extends State<ListRiwayatVaksin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<ModelRiwayatVaksin>>(
          future: widget.userID == null
              ? VaksinService().fetchRiwayatVaksin()
              : VaksinService().fetchRiwayatVaksinByManager(widget.userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 130, right: 130, bottom: 170, top: 170),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  strokeWidth: 6,
                ),
              );
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
                        child: CardRiwayatVaksin(
                          modelRiwayatVaksin: data[index],
                        ));
                  },
                );
              }
            }
          }),
    );
  }
}
