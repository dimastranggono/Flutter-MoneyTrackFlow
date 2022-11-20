import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerNIM = new TextEditingController();
  TextEditingController controllerProdi = new TextEditingController();
  String nama;
  String nim;
  String prodi;

  void SaveNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", controllerNama.text);
  }

  void SaveNIM() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nim", controllerNIM.text);
  }

  void SaveProdi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("prodi", controllerProdi.text);
  }

  Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('nama') ?? "tidak ada nama";
  }

  Future<String> getNIM() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('nim') ?? "tidak ada nim";
  }

  Future<String> getProdi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('prodi') ?? "tidak ada prodi";
  }

  void ShowEditData() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Edit Data'),
            backgroundColor: Colors.white70,
            elevation: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            children: [
              TextField(
                controller: controllerNama,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Nama'),
              ),
              Padding(padding: EdgeInsets.all(14)),
              TextField(
                controller: controllerNIM,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'NIM'),
              ),
              Padding(padding: EdgeInsets.all(14)),
              TextField(
                controller: controllerProdi,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Prodi'),
              ),
              Padding(padding: EdgeInsets.all(14)),
              ElevatedButton(
                onPressed: () {
                  SaveNama();
                  SaveNIM();
                  SaveProdi();
                  getNama().then((value) {
                    controllerNama.text = value;
                    setState(() {});
                  });
                  getNIM().then((value) {
                    controllerNIM.text = value;
                    setState(() {});
                  });
                  getProdi().then((value) {
                    controllerProdi.text = value;
                    setState(() {});
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                child: Text(
                  'Save & Update',
                ),
              )
            ],
          );
        });
  }

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.home_rounded,
            size: 50,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/6682332.jpg',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 140),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.asset(
                        'assets/ijazah-bismillah.jpg',
                        width: 170,
                      ),
                    ),
                    Text(controllerNama.text,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Text(controllerNIM.text,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Text(controllerProdi.text,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    ElevatedButton(
                        onPressed: () {
                          ShowEditData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        child: Text(
                          'Edit Data',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
