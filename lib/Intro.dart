import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'Constants/constants.dart';
import 'local/activity_login.dart';
import 'main.dart';

class Intro extends StatelessWidget {
  // Making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF000000),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/ic_mic.webp'),
      body: const Text(
          'Communicate with your friends & family '
              'with natural voice. Voice messages+voice'
              ' commands, no need to watch screen !'
      ),
      title: const Text(
        'Welcome...',
      ),
      titleTextStyle:Constants().style_IntroTitle,
      bodyTextStyle:  Constants().style_Introbody,
      mainImage: Image.asset(
        'assets/ic_mic.webp',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor:const Color(0xFF000000),
      iconImageAssetPath: 'assets/ic_securedata.webp',
      body: const Text(
          'Secure data in the cloud. Login from any devices.\n'

      ),
      title: const Text('Secure Data'),
      mainImage: Image.asset(
        'assets/ic_securedata.webp',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:Constants().style_IntroTitle,
      bodyTextStyle:  Constants().style_Introbody,
    ),
    PageViewModel(
      pageColor: const Color(0xFF000000),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/ic_mic_2.webp'),
      body: const Text(
          "Get audio traffic updates\n" +
          "Soon free podcasts and public voice messages around you",

      ),
      title: const Text(
        'Audio Traffic Updates',
      ),
      titleTextStyle:Constants().style_IntroTitle,
      bodyTextStyle:  Constants().style_Introbody,
      mainImage: Image.asset(
        'assets/ic_mic_2.webp',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor:const Color(0xFF000000),
      iconImageAssetPath: 'assets/ic_help2.png',
      body: const Text(
          "You can ask the app to do\n" +
          "everything with voice commands, You can find complete instructions in the help baloon",

      ),
      title: const Text('Works without touching'),
      mainImage: Image.asset(
        'assets/ic_help2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:Constants().style_IntroTitle,
      bodyTextStyle:  Constants().style_Introbody,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'IntroViews Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
       Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            // Use Navigator.pushReplacement if you want to dispose the latest route
            // so the user will not be able to slide back to the Intro Views.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => activity_login()),
            );
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
