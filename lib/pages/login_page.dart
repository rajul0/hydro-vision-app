import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // variabel validasi form
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<String> fruitsNames = [
    'Pineapple',
    'Watermelon',
    'Melon',
  ];
  List<String> imageSliders = [
    'assets/image/pineapple.png',
    'assets/image/watermelon.png',
    'assets/image/melon.png',
  ];

  var _selectedIndex = 0;

  // akun data login
  String _username = '';
  String _password = '';

  var _errorLoginMessage = '';
  var _errorUsername = '';
  var _errorPassword = '';

  Future<void> _login() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      if (_errorUsername != '' || _errorPassword != '') {
        setState(() {
          _errorLoginMessage = "Username & Password can't be Empty";
        });
      } else {
        await auth.signInWithEmailAndPassword(
            email: '${_username}@hvx.com', password: _password);
        // mendapatkan sebagai akunnya
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (_) {
      setState(() {
        _errorLoginMessage = "Username & Password doesn't valid ";
      });
    }
  }

  void onConnect() {
    log('Connect');
  }

  void onDisconnect() {
    log('Disconnect');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF0F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 72.65,
            left: 14.31,
            right: 14.31,
            bottom: 17.29,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "HydroVisionX",
                    style: TextStyle(
                      fontSize: 36.0,
                      color: Color(0xFFF18D6C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                "Pantau Sawah Anda",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Color(0xFFB9BECC),
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 28.69,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 200.0,
                decoration: BoxDecoration(
                    color: Color(0xFFFEFEFE),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/img/sawah.jpg'), // Ganti dengan path gambar Anda
                      fit: BoxFit
                          .cover, // Mengatur gambar agar sesuai dengan ukuran Container
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFFFFF),
                        offset: Offset(-4, -4),
                        blurRadius: 13.0,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(35, 0, 0, 0),
                        blurRadius: 13.0,
                        offset: Offset(4, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(19.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.1, top: 16.2, right: 15.1, bottom: 31.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 550.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(35, 0, 0, 0),
                                blurRadius: 13.0,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(19.0))),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                            left: 12.1,
                            right: 12.1,
                            bottom: 17.1,
                          ),
                          child: Form(
                            autovalidateMode: _autoValidateMode,
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _errorLoginMessage != ''
                                      ? Container(
                                          width: double.infinity,
                                          child: Text(
                                            _errorLoginMessage,
                                            style: TextStyle(
                                              fontFamily: 'InriaSans',
                                              fontSize: 14.0,
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 0.0,
                                        ),
                                  Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEEF0F6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(35, 0, 0, 0),
                                            blurRadius: 13.0,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 93.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEF0F6),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0)),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      141, 255, 255, 255)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0x1642526B),
                                                  blurRadius: 8,
                                                  offset: Offset(4, 4),
                                                  spreadRadius: 0,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x3FFFFFFF),
                                                  blurRadius: 16,
                                                  offset: Offset(-4, -4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Text("User",
                                                  style: TextStyle(
                                                    color: Color(0xFF707585),
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _usernameController,
                                              validator: (value) {
                                                if (value == '') {
                                                  setState(() {
                                                    _errorUsername =
                                                        "Username can't be empty";
                                                  });
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {
                                                setState(() {
                                                  _errorLoginMessage = '';
                                                  _errorUsername = '';
                                                  _username = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFFEEF0F6),
                                                labelStyle: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 14.0,
                                                    fontFamily: 'Poppins'),
                                                hintText: 'Username',
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.3),
                                                    fontSize: 14.0,
                                                    fontFamily: 'Poppins'),
                                                contentPadding: EdgeInsets.only(
                                                  top: 13.0,
                                                  bottom: 12.0,
                                                  left: 18.0,
                                                  right: 18.0,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                9.0)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            141,
                                                            255,
                                                            255,
                                                            255))),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(9.0)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          141, 255, 255, 255)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(9.0)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          141, 255, 255, 255)),
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Color(0xFF000000),
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEEF0F6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(35, 0, 0, 0),
                                            blurRadius: 13.0,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 93.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEF0F6),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0)),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      141, 255, 255, 255)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0x1642526B),
                                                  blurRadius: 8,
                                                  offset: Offset(4, 4),
                                                  spreadRadius: 0,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x3FFFFFFF),
                                                  blurRadius: 16,
                                                  offset: Offset(-4, -4),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Text("Pass",
                                                  style: TextStyle(
                                                    color: Color(0xFF707585),
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _passwordController,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == '') {
                                                  setState(() {
                                                    _errorUsername =
                                                        "Password can't be empty";
                                                  });
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {
                                                setState(() {
                                                  _errorLoginMessage = '';
                                                  _errorPassword = '';
                                                  _password = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFFEEF0F6),
                                                labelStyle: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 14.0,
                                                    fontFamily: 'Poppins'),
                                                hintText: 'Password',
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.3),
                                                    fontSize: 14.0,
                                                    fontFamily: 'Poppins'),
                                                contentPadding: EdgeInsets.only(
                                                  top: 13.0,
                                                  bottom: 12.0,
                                                  left: 18.0,
                                                  right: 18.0,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                9.0)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            141,
                                                            255,
                                                            255,
                                                            255))),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(9.0)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          141, 255, 255, 255)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(9.0)),
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          141, 255, 255, 255)),
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Color(0xFF000000),
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: 131.0,
                                    height: 54.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _login();
                                          // Navigator.pushReplacement(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           HomePage()),
                                          // );
                                        } else {
                                          setState(() {
                                            _autoValidateMode =
                                                AutovalidateMode.always;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        backgroundColor: Color(0xFFF18D6C),
                                        elevation: 6.0,
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Color(0xFF707585),
                                          fontFamily: 'Poppins',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
