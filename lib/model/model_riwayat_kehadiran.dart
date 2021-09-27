//@dart=2.9

class ListRiwayatKehadiran {
  final List<ModelRiwayatKehadiran> listRiwayatKehadiran;

  ListRiwayatKehadiran({this.listRiwayatKehadiran});

  factory ListRiwayatKehadiran.fromJson(List<dynamic> json) =>
      ListRiwayatKehadiran(
        listRiwayatKehadiran: List<ModelRiwayatKehadiran>.from(
            json.map((x) => ModelRiwayatKehadiran.fromJson(x))),
      );
}

class ModelRiwayatKehadiran {
  final int id;
  final List<String> location;
  final String time;
  final String description;
  final String picture;
  final String answer1;
  final String answer2;
  final String answer3;
  final bool status;

  ModelRiwayatKehadiran(
      {this.id,
      this.location,
      this.time,
      this.answer1,
      this.answer2,
      this.answer3,
      this.description,
      this.picture,
      this.status});

  factory ModelRiwayatKehadiran.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatKehadiran(
        id: json["id"] ?? null,
        location: List<String>.from(json["location"].map((x) => x)) ?? [],
        time: json["time"] ?? "",
        answer1: json["answer1"] ?? "",
        answer2: json["answer2"] ?? "",
        answer3: json["answer3"] ?? "",
        description: json["description"]=="" ? "-":json["description"],
        picture: json["picture"] ?? "",
        status: json["status"] ?? false,
      );
}
