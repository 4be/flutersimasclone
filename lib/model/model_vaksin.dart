//@dart=2.9

class ListRiwayatVaksin {
  final List<ModelRiwayatVaksin> listRiwayatVaksin;

  ListRiwayatVaksin({this.listRiwayatVaksin});

  factory ListRiwayatVaksin.fromJson(List<dynamic> json) => ListRiwayatVaksin(
        listRiwayatVaksin:
            List<ModelRiwayatVaksin>.from(json.map((x) => ModelRiwayatVaksin.fromJson(x))),
      );
}

class ModelRiwayatVaksin {
  final String createdAt;
  final String namaVaksin;
  final String kegunaan;
  final String fileVaksin;
  final String deskripsi;

  ModelRiwayatVaksin({
    this.createdAt,
    this.namaVaksin,
    this.kegunaan,
    this.fileVaksin,
    this.deskripsi,
  });

  factory ModelRiwayatVaksin.fromJson(Map<String, dynamic> json) => ModelRiwayatVaksin(
        createdAt: json["createdAt"]??"-",
        namaVaksin: json["namaVaksin"]??"-",
        kegunaan: json["kegunaanVaksin"]??"-",
        fileVaksin: json["fileVaksin"]??"-",
        deskripsi: json["deskripsi"]??"-",
      );
}
