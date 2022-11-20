import 'package:bm_project2/models/UangKas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyFlowTab extends StatefulWidget {
  @override
  State<MoneyFlowTab> createState() => _MoneyFlowTabState();
}

class _MoneyFlowTabState extends State<MoneyFlowTab> {
  TextEditingController controllerKas = new TextEditingController();
  TextEditingController controllerDetail = new TextEditingController();
  TextEditingController controllerKasKurang = new TextEditingController();
  TextEditingController controllerDetailKurang = new TextEditingController();
  int uangMasuk;
  int uangKurang;
  int total = 0;
  String trackUang = "none";
  String trackdetails = "none";
  bool Kondisitambahkas = false;
  bool Kondisikurangkas = false;
  bool isReloaded = false;
  Color notAccessibleTambah, notAccessibleKurang;
  Color indicatorKas;

  void showPopup() {
    //POP UP UNTUK KEUANGAN MASUK
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Tambah kas'),
            children: [
              TextField(
                controller: controllerKas,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    labelText: 'Uang masuk',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              Padding(padding: EdgeInsets.all(8)),
              TextField(
                controller: controllerDetail,
                decoration: InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              ElevatedButton(
                  onPressed: () {
                    Kondisitambahkas == true;

                    Save();

                    getKas().then((value) {
                      uangMasuk = int.tryParse(value);
                      total = total + uangMasuk;

                      trackUang = uangMasuk.toString();
                      indicatorKas = Colors.blue;
                      setState(() {});
                    });

                    getDetails().then((value) {
                      trackdetails = value;
                      controllerDetail.text = trackdetails;
                      setState(() {});
                    });

                    SaveKetMasuk();

                    SetTotal();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Simpan'),
                      Icon(
                        Icons.save_as_rounded,
                        size: 40,
                      )
                    ],
                  ))
            ],
          );
        });
  }

  void showPopupKurang() {
    // POPUP UNTUK KEUANGAN KELUAR
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Kas Keluar'),
            children: [
              TextField(
                controller: controllerKasKurang,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    labelText: 'uang keluar',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              Padding(padding: EdgeInsets.all(8)),
              TextField(
                controller: controllerDetailKurang,
                decoration: InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              ElevatedButton(
                  onPressed: () {
                    Kondisikurangkas == true;

                    SaveKurang();

                    getKasKurang().then((value) {
                      uangKurang = int.tryParse(value);
                      total = total - uangKurang;

                      trackUang = uangKurang.toString();
                      controllerKas.text = trackUang;
                      indicatorKas = Colors.red;
                      setState(() {});
                    });

                    getKurangDetails().then((value) {
                      trackdetails = value;
                      controllerDetailKurang.text = trackdetails;
                      setState(() {});
                    });

                    SaveKetKeluar();

                    SetTotal();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Simpan'),
                      Icon(
                        Icons.save_as_rounded,
                        size: 40,
                      )
                    ],
                  ))
            ],
          );
        });
  }

  void Save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("balance", controllerKas.text);
    pref.setString("details", controllerDetail.text);
  }

  void SaveKurang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("balanceKurang", controllerKasKurang.text);
    pref.setString("detailsKurang", controllerDetailKurang.text);
  }

  //trial error detail kas
  void SaveKetMasuk() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("UangMasuk", uangMasuk.toString());
    pref.setString("DetailsUangMasuk", controllerDetail.text);
  }

  // trial error detail kas
  void SaveKetKeluar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("UangKeluar", uangKurang.toString());
    pref.setString("DetailsUangKeluar", controllerDetailKurang.text);
  }

  Future<String> getUangMasuk() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("UangMasuk") ?? "noll";
  }

  Future<String> getDetailsMasuk() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("DetailsUangMasuk") ?? "no details";
  }

  Future<String> getUangKeluar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("UangKeluar") ?? "noll";
  }

  Future<String> getDetailsKeluar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("DetailsUangKeluar") ?? "no Details";
  }

  void SetTotal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("updateTotal", total);
  }

  Future<int> getTotal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("updateTotal") ?? 0;
  }

  Future<String> getKasKurang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("balanceKurang") ?? "Balance : not lOADED";
  }

  Future<String> getKas() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("balance") ?? "Balance : Not Loaded";
  }

  Future<String> getDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("details") ?? "Not Loaded";
  }

  Future<String> getKurangDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("detailsKurang") ?? "Not loaded";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              width: 260,
              height: 190,
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        spreadRadius: 0.6,
                        blurRadius: 0.6,
                        offset: Offset(4, 6))
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Your Balance : ' + total.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800),
                      ),
                      Icon(
                        Icons.attach_money_rounded,
                        size: 38,
                        color: Colors.greenAccent,
                      )
                    ],
                  ),
                  Text(
                    'Attach details everytime you spend/add balance',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              (isReloaded == true) ? showPopupKurang() : null;
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.grey,
                                backgroundColor: notAccessibleKurang),
                            child: Text(
                              'Kurangi KAS -',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              (isReloaded == true) ? showPopup() : null;
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black54,
                                backgroundColor: notAccessibleTambah),
                            child: Text(
                              'Tambah KAS +',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getTotal().then((value) {
                        total = value;
                        setState(() {
                          isReloaded = true;
                          if (isReloaded == true) {
                            notAccessibleTambah = Colors.greenAccent;
                            notAccessibleKurang = Colors.black;
                          } else {
                            notAccessibleTambah = Colors.grey;
                            notAccessibleKurang = Colors.grey;
                          }
                        });
                      });

                      if (Kondisitambahkas == true) {
                        getUangMasuk().then((value) {
                          trackUang = value;
                          setState(() {});
                        });
                        getDetailsMasuk().then((value) {
                          trackdetails = value;
                          setState(() {});
                        });
                      } else {
                        getUangKeluar().then((value) {
                          trackUang = value;
                          setState(() {});
                        });
                        getDetailsKeluar().then((value) {
                          trackdetails = value;
                          setState(() {});
                        });
                      }
                    },
                    child: Text('Reload Balance',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Details Money Flow',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w700),
                )),
            Container(
              width: 220,
              height: 150,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Text(
                    'Recent Details Reciept',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  ),

                  //TRIAL AND ERORRRRRRRR
                  Text(trackUang,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: indicatorKas,
                          fontWeight: FontWeight.w700)),
                  Text(
                    trackdetails,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: indicatorKas,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
