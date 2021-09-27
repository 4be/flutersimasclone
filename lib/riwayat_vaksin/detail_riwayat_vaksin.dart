//@dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simas/model/model_vaksin.dart';
import 'package:simas/routes/routes.dart';
import 'package:simas/services/izin_service.dart';
import 'package:simas/constant/colors.dart' as colors;

class DetailRiwayatVaksin extends StatefulWidget {
  final ModelRiwayatVaksin modelRiwayatVaksin;
  final int index;

  const DetailRiwayatVaksin({Key key, this.index, this.modelRiwayatVaksin})
      : super(key: key);

  @override
  _DetailRiwayatVaksinState createState() => _DetailRiwayatVaksinState();
}

class _DetailRiwayatVaksinState extends State<DetailRiwayatVaksin> {
  String fileName;
  String date = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  void initState() {
    fileName = date +
        widget.modelRiwayatVaksin.fileVaksin.substring(
            widget.modelRiwayatVaksin.fileVaksin.lastIndexOf("/") + 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime;
    convertDateTime(String time) {
      dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time);
      return DateFormat("dd MMM yyyy").format(dateTime);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.3),
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nama Vaksin",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      widget.modelRiwayatVaksin.namaVaksin,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tanggal Upload",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      convertDateTime(widget.modelRiwayatVaksin.createdAt),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kegunaan Vaksin :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.modelRiwayatVaksin.kegunaan,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    Text("File Bukti :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 4.0),
                                    child: Text(fileName),
                                  ),
                                )),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: colors.Red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.upload_file,
                                      color: colors.White,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox.expand(
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(onTap: () async {
                                  await IzinServices().downloadPdf(
                                      context: context,
                                      urlPath:
                                          widget.modelRiwayatVaksin.fileVaksin,
                                      fileName: fileName);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.modelRiwayatVaksin.deskripsi,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: height * 0.05,
                child: GestureDetector(
                  onTap: () {
                    backScreen(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 42,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
