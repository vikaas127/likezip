import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ziplike/Constants/constants.dart';

import '../Search.dart';

class guide extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return guide_state();
  }

}
class guide_state extends State<guide>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Color(0xFF272A36),
      title: Text('LikeZAP'),
      actions: [
        IconButton(
          icon: Icon(Icons.search,color: Colors.white,),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return SearchDialog(title: 'Title ', content: 'Dialog content');
              },
            );
          },
        )
      ],
    ) ,
      body: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
        children: [
        Text("Voice Chats",style: Constants().style_sign,),

        Text("Say \"Hello Zap\"\n(Likezap says YES)\n\"Send New message\"\n(Likezap ask receiver username)\n" "Say Mom at the same time \nChat opens\n\"Hello Zap\"\n\"New voice message\""
      "\nLikezap start recording for 10 seconds \n\"Back to chat list\"\nLikeZap will return to Chats list"),
        Divider(),
        Text("YouTube",style: Constants().style_sign,),
        Divider(),
        Text("To go on YouTube\nSay \"Hello Zap\"\n\"Open video\""),
        Divider(),
        Text("Most trending video starts automatically Use your hand over your phone screen without touching it, to"
            " pause video (sensor have to be turned on)"
        ),
        Divider(),
        Text("Say \"Hello Zap\"\n\"Play video\"\nVideo resume\nUse sensor to pause it\n\"Hello Zap"
            "\"\n\"Play next video\"\nNext video is played\nUse sensor to pause video\nSay \"Hello Zap\"\n\"Like video\" to like it"
            ),
Divider(),
Text("If you need to go back to chats after receiving voice notification or to send new message\nUse sensor "
    "to pause video if played\nSay \"Hello Zap\"\n\"Open chat\""),




      ],));
  }

}