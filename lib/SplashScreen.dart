import 'package:bm_project2/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/3497813.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.only(top: 590),
              height: 70,
              width: 240,
              decoration: BoxDecoration(color: Colors.white38),
              child: Column(
                children: [
                  Text(
                    'Welcome! \n Ingin manage Uang anda?',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                    ),
                  ),
                  Text('Coba pertama kali mengatur keuangan anda',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                      return HomePage();
                    }));
                  }, child: Text('Mari Coba!'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    )
                  ),
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
