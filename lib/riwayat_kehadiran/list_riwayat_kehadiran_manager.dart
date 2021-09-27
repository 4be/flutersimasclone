//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/model/model_riwayat_kehadiran.dart';
import 'package:simas/riwayat_kehadiran/card_riwayat_kehadiran.dart';
import 'package:simas/services/kehadiran_service.dart';

class ListRiwayatKehadiranManager extends StatefulWidget {
  final bool status;
  final int id;

  const ListRiwayatKehadiranManager({Key key, this.status, this.id})
      : super(key: key);

  @override
  _ListRiwayatKehadiranManagerState createState() =>
      _ListRiwayatKehadiranManagerState();
}

class _ListRiwayatKehadiranManagerState
    extends State<ListRiwayatKehadiranManager> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<ModelRiwayatKehadiran>>(
        future: widget.status == true
            ? KehadiranServices().fetchRiwayatClockInByManager(widget.id)
            : KehadiranServices().fetchRiwayatClockOutByManager(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 150, right: 150, top: 165, bottom: 165),
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
                padding: EdgeInsets.only(top: 5),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardRiwayatKehadiran(
                      modelRiwayatKehadiran: data[index],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
