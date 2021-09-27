//@dart=2.9

class ListRiwayatKesehatan {
  final List<ModelRiwayatKesehatan> listRiwayatKesehatan;

  ListRiwayatKesehatan({this.listRiwayatKesehatan});

  factory ListRiwayatKesehatan.fromJson(List<dynamic> json) =>
      ListRiwayatKesehatan(
        listRiwayatKesehatan: List<ModelRiwayatKesehatan>.from(
            json.map((x) => ModelRiwayatKesehatan.fromJson(x))),
      );
}

class ModelRiwayatKesehatan {
  final String createdAt;
  final String updatedAt;
  final String kondisiFisik;
  final String kondisiMental;
  final String statusOlahraga;
  final String deskripsi;
  final String userid;
  final String linkStrava;

  ModelRiwayatKesehatan({
    this.createdAt,
    this.updatedAt,
    this.kondisiFisik,
    this.kondisiMental,
    this.statusOlahraga,
    this.deskripsi,
    this.userid,
    this.linkStrava,
  });

  factory ModelRiwayatKesehatan.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatKesehatan(
        createdAt: json["createdAt"]??"-",
        updatedAt: json["updatedAt"]??"-",
        kondisiFisik: json["kondisiFisik"]??"-",
        kondisiMental: json["kondisiMental"]??"-",
        statusOlahraga: json["statusOlahraga"]??"-",
        deskripsi: json["deskripsi"]??"-",
        userid: json["userid"]??"-",
        linkStrava: json["linkstrava"]??"-",
      );
}
