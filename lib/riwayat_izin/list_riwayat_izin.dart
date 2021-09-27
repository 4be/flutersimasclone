//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/model/model_riwayat_izin.dart';
import 'package:simas/riwayat_izin/card_riwayat_izin.dart';
import 'package:simas/services/izin_service.dart';

class ListRiwayatIzin extends StatefulWidget {
  final int userID;

  const ListRiwayatIzin({Key key, this.userID}) : super(key: key);

  @override
  _ListRiwayatIzinState createState() => _ListRiwayatIzinState();
}

class _ListRiwayatIzinState extends State<ListRiwayatIzin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<ModelRiwayatIzin>>(
          future: widget.userID == null
              ? IzinServices().fetchRiwayatIzin()
              : IzinServices().fetchRiwayatIzinByManager(widget.userID),
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
              }else{
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
                      child: CardRiwayatIjin(
                        modelRiwayatIjin: data[index],
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
