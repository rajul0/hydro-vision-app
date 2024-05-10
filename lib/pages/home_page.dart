import "dart:async";

import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import "package:flutter_inner_shadow/flutter_inner_shadow.dart";
import "package:hydro_vision_app/pages/pump_history.dart";

class HomePage extends StatefulWidget {
  // const HomePage({
  //   Key? key,
  //   required this.machineName,
  //   required this.status,
  //   required this.door,
  // }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  bool? statusMachineIn = false;
  bool? statusMachineOut = false;
  double? ketinggianAir = 0;

  late var timer;

  void changeStatusIn() {
    changeStatusMachine("status_machine_in", !statusMachineIn!);
  }

  void changeStatusOut() {
    changeStatusMachine("status_machine_out", !statusMachineOut!);
  }

  @override
  void initState() {
    super.initState();
    //manggil firebase
    if (mounted) {
      FirebaseDatabase.instance
          .ref('/')
          .child('ketinggian_air') // Menggunakan '' sebagai kunci
          .onValue
          .listen((event) {
        // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
        if (event.snapshot.value != null) {
          // Konversi nilai ke tipe data int
          setState(() {
            ketinggianAir = double.parse(event.snapshot.value.toString());
          });
        }
      });

      FirebaseDatabase.instance
          .ref()
          .child('status_machine_in') // Menggunakan '' sebagai kunci
          .onValue
          .listen((event) {
        // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
        if (event.snapshot.value != null) {
          // Konversi nilai ke tipe data int
          setState(() {
            statusMachineIn = bool.parse(event.snapshot.value.toString());
          });
        }
      });

      FirebaseDatabase.instance
          .ref()
          .child('status_machine_out') // Menggunakan '' sebagai kunci
          .onValue
          .listen((event) {
        // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
        if (event.snapshot.value != null) {
          // Konversi nilai ke tipe data int
          setState(() {
            statusMachineOut = bool.parse(event.snapshot.value.toString());
          });
        }
      });
      timer = new Timer.periodic(
          Duration(seconds: 60), (Timer t) => setState(() {}));
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF0F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 62.65,
            left: 36.0,
            right: 36.0,
            bottom: 17.29,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: Text(
                  "HydroVisionX",
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Color(0xFFF18D6C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Pantau Sawah Anda",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0xFFB9BECC),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 38.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 58.0,
                        height: 58.0,
                        child: ElevatedButton(
                          onPressed: () {
                            changeStatusIn();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: statusMachineIn!
                                ? Color(0xFFFFB39A)
                                : Color(0xFF707585),
                            elevation: 6.0,
                            shadowColor: Color(0xFFDCDDE2),
                          ),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Image.asset(
                              'assets/img/icon_on_off.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Tambah Air",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.0,
                            color: Color(0xFF707585)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 58.0,
                        height: 58.0,
                        child: ElevatedButton(
                          onPressed: () {
                            changeStatusOut();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: statusMachineOut!
                                ? Color(0xFFFFB39A)
                                : Color(0xFF707585),
                            elevation: 6.0,
                            shadowColor: Color(0xFFDCDDE2),
                          ),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: Image.asset(
                              'assets/img/icon_on_off.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Kurangi Air",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.0,
                            color: Color(0xFF707585)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 38.0,
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Color(0xFFEEF0F6),
                    border: Border.all(color: Color(0xFFFFD6C8), width: 2.0),
                  ),
                  child: InnerShadow(
                    shadows: [
                      Shadow(
                          color: Color(0xFFFFFFFF),
                          blurRadius: 25,
                          offset: Offset(-4, -6)),
                      Shadow(
                          color: Color(0xFF42536B).withOpacity(0.22),
                          blurRadius: 6,
                          offset: Offset(2, 2))
                    ],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Color(0xFFEEF0F6),
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 23, right: 23.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 19.0,
                                    child: Image.asset(
                                        'assets/img/water_level.png'),
                                  ),
                                  Text(
                                    "Ketinggian Air",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF707585),
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "$ketinggianAir Cm",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF707585),
                                        fontFamily: 'Poppins',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 33.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PumpHistoryPage()),
                  );
                },
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Color(0xFFEEF0F6),
                      border: Border.all(color: Color(0xFFFFD6C8), width: 2.0),
                    ),
                    child: InnerShadow(
                      shadows: [
                        Shadow(
                            color: Color(0xFFFFFFFF),
                            blurRadius: 25,
                            offset: Offset(-4, -6)),
                        Shadow(
                            color: Color(0xFF42536B).withOpacity(0.22),
                            blurRadius: 6,
                            offset: Offset(2, 2))
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Color(0xFFEEF0F6),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 23, right: 23.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                      child: Image.asset(
                                        'assets/img/history.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Riwayat Pompa Air",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF707585),
                                          fontFamily: 'Poppins',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      ">",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF707585),
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeStatusMachine(String field, bool nilai) {
    // Path ke node yang ingin diperbarui dalam database
    String path = '/';

    // Data baru yang ingin Anda simpan
    Map<String, dynamic> newData = {
      field: nilai,
    };

    // Update data dalam database
    _database.child(path).update(newData).then((_) {}).catchError((error) {
      print('Gagal memperbarui data: $error');
    });
  }
}
