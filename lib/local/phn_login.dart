import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import 'otp_screen.dart';
class phn_login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return phn_login_state();
  }

}

class phn_login_state extends State<phn_login>{

TextEditingController _cntrycontroller = new TextEditingController();
TextEditingController _phncontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:Column(
       children: [
         Container(color: Colors.black,
           height: 100,
           width: MediaQuery.of(context).size.width,
           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 40,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Enter your phone number',style:  Constants().style_Introbody,),
               ),
             ],
           ),),
         SizedBox(height: 40,),
         Row(
             children: [
               Container(width: MediaQuery.of(context).size.width*0.30,
                 child: TextField(controller: _cntrycontroller,
                     onTap: (){

                   showCountryPicker(
                     context: context,
                     //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                     exclude: <String>['KN', 'MF'],
                     //Optional. Shows phone code before the country name.
                     showPhoneCode: true,
                     onSelect: (Country country) {
                         _cntrycontroller.text=country.phoneCode;
                       print('Select country: ${country.displayName}');
                     },
                     // Optional. Sets the theme for the country list picker.
                     countryListTheme: CountryListThemeData(
                       // Optional. Sets the border radius for the bottomsheet.
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(40.0),
                         topRight: Radius.circular(40.0),
                       ),
                       // Optional. Styles the search field.
                       inputDecoration: InputDecoration(
                         labelText: 'Search',
                         hintText: 'Start typing to search',
                         prefixIcon: const Icon(Icons.search),
                         border: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: const Color(0xFF8C98A8).withOpacity(0.2),
                           ),
                         ),
                       ),
                     ),
                   );









                 })),
               Container(width: MediaQuery.of(context).size.width*0.65,
                   child: TextField(controller: _phncontroller,
                       decoration: InputDecoration(labelText: 'Phone number')))


    ]
           ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: FlatButton(onPressed:() {
             Navigator.of(context).push(MaterialPageRoute(
                 builder: (context) => OTPScreen(_phncontroller.text)));
           }, child: Container(color: Colors.grey,
               width:MediaQuery.of(context).size.width ,
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Center(child: Text('VERIFY PHONE NUMBER',style: Constants().style_Introbody,)),
               ))),

         ),
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Center(child: Text('By tapping "Verify Phone Number", an \n SMS may be sent. Message & data rates  \n may apply.',style: Constants().style_black15,)),
         )],
     ) ,
   );
  }

}