import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziplike/Constants/constants.dart';

import 'Guide/guide.dart';
import 'Invite Contacts/invite_contact.dart';
import 'Search.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String uid;
  Widget _Drawer (){
    return  Drawer(
      child: Container(color: Color(0xFF272A36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        SizedBox(height: 60,),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.webp'),

        ),
        SizedBox(height: 20,),

        Text("vikaas",style: Constants().style_drawer_text,),SizedBox(height: 20,),

        Text("vikas9497@gmail.com",style: Constants().style_drawer_text,),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => invite_contacts()),
            );
          },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [Container(height: 20,width: 30,
                  child: Image.asset('assets/outline_subscriptions_black_36.png',color: Colors.white,)),Text("Videos",
                style: Constants().style_drawer,)],),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => invite_contacts()),
            );
          },
            child: Row(children: [Container(height: 20,width: 30,
                child: Image.asset('assets/invitecontacts.webp',color: Colors.white,)),Text("Invite Contacts",style: Constants().style_drawer,)],),
          ),
        ),
            SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => invite_contacts()),
            );
          },
            child: Row(children: [
              Container(height: 20,width: 30,
                child: Icon(Icons.share,size: 30,color: Colors.white,)),SizedBox(width: 30,),
              Text("Share",style: Constants().style_drawer,),
            ],),
          ),
        ),
            SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => invite_contacts()),
            );
          },
            child: Row(children: [
              Container(height: 20,width: 30,
                child: Image.asset('assets/ic_securedata.webp',color: Colors.white,)),SizedBox(width: 20,),
              Text("Subscription",style: Constants().style_drawer,)],),
          ),
        ),
            SizedBox(height: 120,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 78.0),
              child: InkWell(onTap: () async {
                await FirebaseAuth.instance.signOut();
                //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
              },
                child: Row(children: [

                  Text("Logout",style: Constants().style_drawer,)],),
              ),
            )

    ],),
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer:_Drawer() ,
      floatingActionButton: FloatingActionButton( backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => guide()));
        },
        child: Icon(Icons.question_answer_outlined,color: Colors.black54,),),
      bottomSheet: Container(color: Colors.black,
        height: 50,width: MediaQuery.of(context).size.width,child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Voice commands tutorial >>>",style: Constants().style_white20,),
      ),),
      appBar: AppBar(backgroundColor: Color(0xFF272A36),
        title: Text('LikeZAP'),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return SearchDialog(title: 'Find Friends ', content: 'Dialog content');
                },
              );
            },
          )
        ],
      ),
      body:Column(
        children: [
          ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context,index){
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: Card(
             color: Color(0xFF272A36),
              shape:  BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              ),
              child: ListTile(leading: Container(height: 50,width: 50,
                  child: Image.asset('assets/profile.webp')),title: Text("jyoti arya",style:Constants().style_white16 ,),trailing: Icon(Icons.more_vert,color:Colors.purpleAccent),)),
        );

      }),
      InkWell(onTap: (){  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => invite_contacts()));},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: Container(
            decoration: const BoxDecoration(

              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:
                Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[

                  Color(0xff475DEF),
                  Color(0xff8247EE)
                ], // red to yellow
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child:  ListTile(leading: Container(height: 50,width: 50,
                    child: Icon(Icons.supervisor_account)),title: Center(child: Text("Invite a friend",style:Constants().style_white16 ,)),
                  ),
          ),
        ),
      )],)
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
  }
}
