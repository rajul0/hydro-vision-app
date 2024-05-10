import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_inner_shadow/flutter_inner_shadow.dart";
import "package:hydro_vision_app/pages/home_page.dart";
import "package:hydro_vision_app/proses_data.dart/get_data.dart";

class PumpHistoryPage extends StatefulWidget {
  // const PumpHistoryPage({
  //   Key? key,
  //   required this.machineName,
  //   required this.status,
  //   required this.door,
  // }) : super(key: key);
  @override
  State<PumpHistoryPage> createState() => _HomePageState();
}

class _HomePageState extends State<PumpHistoryPage> {
  bool? statusMachine = true;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF0F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 61.0,
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
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: SizedBox(
                    height: 16.0,
                    child: Image.asset(
                      "assets/img/back_button.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Center(
                  child: Text(
                    "Riwayat Pompa Air",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFFF18D6C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 38.0),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 11.0,
                          left: 23,
                          right: 23.0,
                          bottom: 11.0,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Waktu',
                                      style: TextStyle(
                                          color: Color(0xFF9096A5),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Banyak Air',
                                      style: TextStyle(
                                          color: Color(0xFF9096A5),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Keterangan',
                                      style: TextStyle(
                                          color: Color(0xFF9096A5),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Color(0xFF9096A5),
                            ),
                            FutureBuilder(
                              future: getRiwayatPompa(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  var data = snapshot.data!;
                                  print(snapshot.data!);
                                  return Column(
                                      children: List.generate(
                                    data.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 55.0,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${data[index]['tanggal']} / "
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontFamily: "Poppins",
                                                        color:
                                                            Color(0xFF9096A5),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data[index]['jam']} WIB"
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily: "Poppins",
                                                        color:
                                                            Color(0xFF9096A5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "${data[index]['banyak_air']} Liter",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFF9096A5),
                                                ),
                                              ),
                                              Text(
                                                data[index]['keterangan'],
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF9096A5),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Container(
                                            width: 100.0,
                                            height: 1.0,
                                            color: Color(0xFFC3C8D2),
                                          ),
                                        ],
                                      );
                                    },
                                  ));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
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
