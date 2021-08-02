import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziplike/Constants/constants.dart';

class invite_contacts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
 return invite_contacts_state();
  }

}
class invite_contacts_state extends State<invite_contacts>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: ListView.builder(itemCount: 100,
       itemBuilder: (context,index){
     return Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(height: 80,width: MediaQuery.of(context).size.width,child: Row(children: [
             Expanded(flex: 2,
               child: Image.asset('assets/profile.webp')), Expanded(flex: 5,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text("Rohit Tyagi",style: Constants().style_black15,),
                     SizedBox(height: 20,),
                     Text("+918233081931",style: Constants().style_gray18,),
                   ],
                 ))
, Expanded(flex: 2,
                 child: Container(height: 35,width: 50,color: Colors.black,
                     child: Center(child: Text("INVITE",style: Constants().style_white16,))))












           ],












           ),),
         ),
      Divider() ],
     );
   }),);
  }

}