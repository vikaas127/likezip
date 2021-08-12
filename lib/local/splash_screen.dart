import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ziplike/Intro.dart';
import 'package:ziplike/appperferance.dart';
import 'package:ziplike/local/phn_login.dart';

import '../Home.dart';
import '../appConstant.dart';
import '../main.dart';
import 'activity_login.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {

  var _visible = true;
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {

    Future.delayed(Duration(seconds: 2))
        .then((value) {

      AppPreferences.getBool(AppConstants.Auth_Token).then((value) {setState(() {
        if (value == true){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Home()
            ),
          );
        }else {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  activity_login(),
            ),
          );

        }
      });


      });});}
  @override
  Future<void> initState()   {
    super.initState();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
 color:Color(0xFF091E38),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.22 ,),
              Center(
                child: Container(
                 height: 300,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),

                  decoration: BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage('assets/splash_screen.webp'), fit: BoxFit.fill),
                  ),

                ),
              ),
              Text('Like Zap',style: GoogleFonts.breeSerif(fontSize: 60,color: Colors.white),),
              Text('Voice Social Network',style: GoogleFonts.sourceSerifPro(fontSize: 20,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}
