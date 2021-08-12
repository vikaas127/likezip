import 'package:flutter/material.dart';
import 'package:ziplike/Constants/constants.dart';
import 'package:ziplike/Model/User.dart';

class UserdetailDialog extends StatelessWidget {
  final User user;

  final List<Widget> actions;

  UserdetailDialog({
    this.user,

    this.actions = const [],
  });
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
      return
        AlertDialog(

      actions: this.actions,
      content: Container(height: 310,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.name}",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "Email: ${user.email}",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "NickName: ${user.nickName}""",
              style: Theme.of(context).textTheme.title,
            ),
            Row(
              children: [
                Text(
                  "Block this user ?",
                  style: Theme.of(context).textTheme.title,
                ),  Center(
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value){
                      isSwitched=value;
                      print(isSwitched);

                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ),
              ],
            ),
            Text("Friends forever"
              ,
              style: Theme.of(context).textTheme.title,
            ),


            SizedBox(height: 20),
            Row(children: [
              // ignore: deprecated_member_use
              Expanded(child: FlatButton
                (onPressed: (){}, child: Container(height: 40,
                  color: Colors.grey,
                  child: Center(child: Text("CANCEL",style: Constants().style_white16,))))),
              // ignore: deprecated_member_use
              Expanded(child: FlatButton(onPressed: (){}, child: Container(height: 40,
                  color: Colors.grey,
                  child: Center(child: Text("SAVE",style:  Constants().style_white16,)))))
            ],)

          ],
        ),
      ),
    );});
  }
}