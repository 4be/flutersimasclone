//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/model/model_riwayat_kesehatan.dart';
import 'package:simas/riwayat_kesehatan/card_riwayat_kesehatan.dart';
import 'package:simas/services/kesehatan_service.dart';

class ListRiwayatKesehatan extends StatefulWidget {
  final int userID;

  const ListRiwayatKesehatan({Key key, this.userID}) : super(key: key);

  @override
  _ListRiwayatKesehatanState createState() => _ListRiwayatKesehatanState();
}

class _ListRiwayatKesehatanState extends State<ListRiwayatKesehatan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<ModelRiwayatKesehatan>>(
          future: widget.userID == null
              ? KesehatanServices().fetchKesehatan()
              : KesehatanServices().fetchKesehatanByManager(widget.userID),
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
                      child: CardRiwayatKesehatan(
                        modelRiwayatKesehatan: data[index],
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
