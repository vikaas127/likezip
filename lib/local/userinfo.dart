import 'package:flutter/material.dart';
import 'package:ziplike/Constants/constants.dart';

class UserInfoDialog extends StatelessWidget {
  final String title;

  final List<Widget> actions;

  UserInfoDialog({
    this.title,

    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      actions: this.actions,
      content: Container(height: 135,
        child: Column(
          children: [

            Container(
              child: TextFormField(
                //  controller: _textEditConEmail,
                //  focusNode: _passwordEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                // validator: _validateEmail,
                onFieldSubmitted: (String value) {
                  // FocusScope.of(context).requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                  labelText: ' Enter Email/ Phone Number',
                  //prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                //  controller: _textEditConEmail,
                //  focusNode: _passwordEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                // validator: _validateEmail,
                onFieldSubmitted: (String value) {
                  // FocusScope.of(context).requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                  labelText: ' Enter Email/ Phone Number',
                  //prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(children: [
              // ignore: deprecated_member_use
              Expanded(child: FlatButton
                (onPressed: (){}, child: Container(height: 40,
                  color: Colors.black,
                  child: Center(child: Text("CANCEL",style: Constants().style_white16,))))),
              // ignore: deprecated_member_use
              Expanded(child: FlatButton(onPressed: (){}, child: Container(height: 40,
                  color: Colors.black,
                  child: Center(child: Text("SEARCH",style:  Constants().style_white16,)))))
            ],)

          ],
        ),
      ),
    );
  }
}