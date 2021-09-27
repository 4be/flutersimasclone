//@dart=2.9

class ListTeam {
  final List<ModelTeam> listTeam;

  ListTeam({this.listTeam});

  factory ListTeam.fromJson(List<dynamic> json) => ListTeam(
        listTeam: List<ModelTeam>.from(json.map((x) => ModelTeam.fromJson(x))),
      );
}

class ModelTeam {
  final int id;
  final String firstname;
  final String lastname;
  final String address;
  final String email;
  final String picture;
  final String nik;
  final String nikManager;
  final String divisi;

  ModelTeam({
    this.id,
    this.firstname,
    this.lastname,
    this.address,
    this.email,
    this.picture,
    this.nik,
    this.nikManager,
    this.divisi,
  });

  factory ModelTeam.fromJson(Map<String, dynamic> json) => ModelTeam(
        id: json["id"] ?? null,
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        address: json["address"] ?? "",
        email: json["email"] ?? "",
        picture: json["picture"] ?? "",
        nik: json["nik"] ?? "",
        nikManager: json["nikManager"] ?? "",
        divisi: json["divisi"] ?? "",
      );
}
