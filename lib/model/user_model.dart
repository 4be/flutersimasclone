//@dart=2.9
class UserModel {
  int id;
  String firstName;
  String lastName;
  String address;
  String email;
  String dob;
  String nik;
  String role;
  String userPicture;

  String division;
  UserModel(
      {this.id,
      this.nik,
      this.firstName,
      this.address,
      this.email,
      this.dob,
      this.lastName,
      this.role,
      this.userPicture,
      this.division});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      lastName: json["lastname"] ?? "-",
      firstName: json["firstname"] ?? "",
      address: json["address"] ?? "-",
      //phone:json["phone"],
      email: json["email"] ?? "-",
      dob: json["dob"] ?? "-",
      role: json["appUserRole"],
      userPicture: json["picture"],
      division: json["divisi"] ?? "-",
      nik: json["nik"] ?? "-");
}
