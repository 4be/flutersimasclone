//@dart=2.9

class ListRiwayatIzin {
  final List<ModelRiwayatIzin> listRiwayatIzin;

  ListRiwayatIzin({this.listRiwayatIzin});

  factory ListRiwayatIzin.fromJson(List<dynamic> json) =>
      ListRiwayatIzin(
        listRiwayatIzin: List<ModelRiwayatIzin>.from(
            json.map((x) => ModelRiwayatIzin.fromJson(x))),
      );
}

class ModelRiwayatIzin {
  final String createdAt;
  final String updatedAt;
  final int id;
  final String picture;
  final String izinType;
  final String description;
  final String status;
  final String starttime;
  final String endtime;

  ModelRiwayatIzin({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.picture,
    this.izinType,
    this.description,
    this.status,
    this.starttime,
    this.endtime,
  });

  factory ModelRiwayatIzin.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatIzin(
        createdAt: json["createdAt"]??"-",
        updatedAt: json["updatedAt"]??"-",
        id: json["id"]??null,
        picture: json["picture"]??"",
        izinType: json["izinType"]??"-",
        description: json["description"]==""?"-": json["description"],
        status: json["status"]??"-",
        starttime: json["starttime"]??"-",
        endtime: json["endtime"]??"-",
      );
}
