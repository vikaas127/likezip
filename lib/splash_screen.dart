import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ziplike/Intro.dart';

import 'main.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      /*CommonDetailsProvider commonDetailsProvider =
      Provider.of<CommonDetailsProvider>(context, listen: false);
      await commonDetailsProvider.initPreferences();
      commonDetailsProvider.initCamera();
      bool isLoggedIn = commonDetailsProvider.getPreferencesInstance
          .getBool(PreferenceConstants.IS_USER_LOGGED_IN);*/

        Navigator.push(context,MaterialPageRoute(builder: (_) => Intro()));
     //   Navigator.of(context).pushReplacementNamed(MemoryPage.routeName);
      /* else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
       // Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }*/
    });
    super.initState();
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
