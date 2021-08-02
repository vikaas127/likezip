import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ziplike/Constants/constants.dart';
import '../Home.dart';
import 'phn_login.dart';

class activity_login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return  activity_login_state();
  }

}
class activity_login_state extends State<activity_login>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height:MediaQuery.of(context).size.height*0.35 ,),
      Center(child: Text("LikeZap",style:Constants().style_appname,)),
      SizedBox(height: 20,),
      Center(child: Text("Sign In",style:Constants().style_sign,)),
      SizedBox(height: 20,),
      Padding(

        padding: const EdgeInsets.all(8.0),
        child: InkWell(onTap: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
        /*  Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => phn_login()),
          );*/
        },
          child: Container(height: 80,
            width:MediaQuery.of(context).size.width ,
            color: Colors.black,
          child:Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Container(
                  child: Icon(Icons.call,color: Colors.white,size: 30,),width: 90,
              ),
    Expanded(child: Text('Sign In with Phone',style: Constants().style_Introbody,),),


            ],
          ) ,),
        ),
      ),
    ],),
  );
  }

}