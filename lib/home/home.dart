//@dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simas/constant/app_tools.dart';
import 'package:simas/home/home_drawer.dart';
import 'package:simas/home/home_image.dart';
import 'package:simas/home/home_menu.dart';
import 'package:simas/constant/colors.dart' as colors;
import 'package:simas/izin/form_izin.dart';
import 'package:simas/kehadiran/kehadiran.dart';
import 'package:simas/kesehatan/check_up_kesehatan/form_kesehatan.dart';
import 'package:simas/model/user_model.dart';
import 'package:simas/profile/edit_profile.dart';
import 'package:simas/riwayat_izin/riwayat_izin.dart';
import 'package:simas/riwayat_kehadiran/riwayat_kehadiran.dart';
import 'package:simas/riwayat_kesehatan/riwayat_kesehatan.dart';
import 'package:simas/riwayat_vaksin/riwayat_vaksin.dart';
import 'package:simas/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simas/services/current_time_service.dart';
import 'package:simas/services/izin_service.dart';
import 'package:simas/services/user_service.dart';
import 'package:simas/team/team.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel userModel;
  String fileName;

  getClockInStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isClockIn') ?? false;
  }

  getUserModel() async {
    userModel = await UserServices().getUser();
  }

  @override
  void initState() {
    _askPermission();
    getUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserServices().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = snapshot.data;
            return Scaffold(
                backgroundColor: colors.btnSoftGrey,
                drawer: Drawer(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          createDrawerHeader(snapshot.data),
                          ListTile(
                            title: Text('Profile'),
                          ),
                          createDrawerBodyItem(
                              icon: Icons.assignment_ind_outlined,
                              text: 'Edit Profil',
                              onTap: () => changeScreen(context,
                                  EditProfile(userModel: snapshot.data))),
                          // Offstage(
                          //   offstage:
                          //       userModel.role == "ROLE_MANAGER" ? false : true,
                          //   child: createDrawerBodyItem(
                          //       icon: Icons.group_work_outlined,
                          //       text: 'Team',
                          //       onTap: () => changeScreen(context, Team())),
                          // ),
                          Divider(),
                          ListTile(
                            title: Text('Export'),
                          ),
                          createDrawerBodyItem(
                              icon: Icons.airplane_ticket_outlined,
                              text: 'Export Riwayat Sakit',
                              onTap: () async {
                                setState(() {
                                  fileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      ".csv";
                                });
                                await IzinServices().downloadPdf2(
                                    context: context,
                                    urlPath:
                                        "http://35.211.87.216/download/${userModel.id}/ijin.csv",
                                    fileName: fileName);
                              }),
                          createDrawerBodyItem(
                              icon: Icons.fact_check_outlined,
                              text: 'Export Kehadiran',
                              onTap: () async {
                                setState(() {
                                  fileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      ".csv";
                                });
                                await IzinServices().downloadPdf2(
                                    context: context,
                                    urlPath:
                                        "http://35.211.87.216/download/${userModel.id}/kehadiran.csv",
                                    fileName: fileName);
                              }),
                          createDrawerBodyItem(
                              icon: Icons.sick_outlined,
                              text: 'Export Info Kesehatan',
                              onTap: () async {
                                setState(() {
                                  fileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      ".csv";
                                });
                                await IzinServices().downloadPdf2(
                                    context: context,
                                    urlPath:
                                        "http://35.211.87.216/download/${userModel.id}/kesehatan.csv",
                                    fileName: fileName);
                              }),
                          Divider(),
                          ListTile(
                            title: Text('Riwayat'),
                          ),
                          createDrawerBodyItem(
                              icon: Icons.checklist_rtl_rounded,
                              text: 'Riwayat Sakit',
                              onTap: () =>
                                  changeScreen(context, RiwayatIzin())),
                          createDrawerBodyItem(
                              icon: Icons.check_circle_outline_rounded,
                              text: 'Riwayat Kehadiran',
                              onTap: () =>
                                  changeScreen(context, RiwayatKehadiran())),
                          createDrawerBodyItem(
                              icon: Icons.local_hotel_outlined,
                              text: 'Riwayat Kesehatan',
                              onTap: () =>
                                  changeScreen(context, RiwayatKesehatan())),
                          createDrawerBodyItem(
                              icon: Icons.local_hospital_outlined,
                              text: 'Riwayat Vaksinasi',
                              onTap: () =>
                                  changeScreen(context, RiwayatVaksin())),
                          Divider(),
                          SizedBox(
                            height: 70,
                          ),
                          createDrawerBodyItem(
                            icon: Icons.logout_outlined,
                            text: 'Log Out',
                            onTap: () => logOut(context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                appBar: AppBar(
                  title: Text('Halaman Utama'),
                  backgroundColor: colors.hdrDarkGrey_hex1,
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                      future: getClockInStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            children: [
                              Container(child: HomeImage()),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 30),
                                child: Container(
                                  // alignment: Alignment.bottomCenter,
                                  child: Wrap(
                                    spacing: 17,
                                    runSpacing: 17,
                                    children: [
                                      HomeMenu(
                                          onBtnclicked: () => changeScreen(
                                              context, FormKesehatan()),
                                          title: 'Informasi Kesehatan',
                                          image:
                                              'assets/icons/ic_riwayatKesehatan.png',
                                          color: 0xff535353),
                                      HomeMenu(
                                          onBtnclicked: () =>
                                              changeScreen(context, FormIzin()),
                                          title: 'Keterangan Sakit',
                                          image:
                                              'assets/icons/ic_izinTidakMasuk.png',
                                          color: 0xff535353),
                                      HomeMenu(
                                          onBtnclicked: () => changeScreen(
                                              context, RiwayatIzin()),
                                          title: 'Riwayat Sakit',
                                          image:
                                              'assets/icons/ic_riwayat_izin.png',
                                          color: 0xff535353),
                                      HomeMenu(
                                          onBtnclicked: () => changeScreen(
                                              context, RiwayatKehadiran()),
                                          title: 'Riwayat Kehadiran',
                                          image:
                                              'assets/icons/ic_riwayatAbsen.png',
                                          color: 0xff535353),
                                      Offstage(
                                        offstage:
                                            userModel.role == "ROLE_MANAGER"
                                                ? false
                                                : true,
                                        child: HomeMenu2(
                                            onBtnclicked: () =>
                                                changeScreen(context, Team()),
                                            title: 'Team',
                                            image: 'assets/icons/group.png',
                                            color: 0xff535353),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !snapshot.data,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: appButton(
                                        btnTxt: "Clock In",
                                        onBtnclicked: () => kehadiran(
                                            context: context,
                                            status: "Clock In"),
                                        btnPadding: 15.0,
                                        btnColor: Colors.red),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: snapshot.data,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: appButton(
                                      btnTxt: "Clock Out",
                                      onBtnclicked: () => kehadiran(
                                          context: context,
                                          status: "Clock Out"),
                                      btnPadding: 15.0,
                                      btnColor: Colors.red,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ));
          } else {
            return SizedBox.shrink();
          }
        });
  }
}

void _askPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.camera,
  ].request();
  print(statuses[Permission.location]);
  print(statuses[Permission.storage]);
  print(statuses[Permission.camera]);
  var statusCamera = await Permission.camera.status;
  if (statusCamera.isDenied) {
    Permission.camera;
  }
  var statusStorage = await Permission.storage.status;
  if (statusStorage.isDenied) {
    Permission.storage;
  }
  var statusLocation = await Permission.location.status;
  if (statusLocation.isDenied) {
    Permission.location;
  }
}

kehadiran({BuildContext context, String status}) async {
  final String time = await CurrentTimeServices().getCurrentTime();
  changeScreen(
      context,
      Kehadiran(
        currentTime: time,
        status: status,
      ));
}

logOut({BuildContext context}) async {
  await UserServices().logOut(context: context);
}
