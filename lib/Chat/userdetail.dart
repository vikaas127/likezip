import 'package:flutter/material.dart';
import 'package:ziplike/Constants/constants.dart';

class UserdetailDialog extends StatelessWidget {
  final String title;

  final List<Widget> actions;

  UserdetailDialog({
    this.title,

    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      actions: this.actions,
      content: Container(height: 258,
        child: Column(
          children: [
            Text(
              "Jyoti arya",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "Email: jyotiarya1298@gmail.com",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "NickName:",
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "Block this user ?",
              style: Theme.of(context).textTheme.title,
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
    );
  }
}