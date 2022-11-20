import 'package:bm_project2/ProfilePage.dart';
import 'package:bm_project2/TabManage.dart';
import 'package:bm_project2/tab/TabMoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 7),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome!',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfilePage();
                      }));
                    },
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 50,
                    ),
                  )
                ],
              ),
              Container(
                width: 340,
                height: 190,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 0.9,
                          spreadRadius: 0.5,
                          offset: Offset(7, 9),
                          blurStyle: BlurStyle.solid)
                    ]),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Manage \nTodos and MoneyFlow',
                              style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.greenAccent,
                            size: 50,
                          )
                        ]),
                    Text(
                      'Be Smart Be Wise, our future is shaky !',
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'GO MANAGE YOUR ECO!',
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.black45,
                              fontWeight: FontWeight.w700),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TabManagePage();
                            }));
                          },
                          child: Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 40,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                        )
                      ],
                    )
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
