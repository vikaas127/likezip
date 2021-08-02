import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  SearchDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Column(
        children: [
          Text(
            this.content,
            style: Theme.of(context).textTheme.body1,
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
                  icon: Icon(Icons.email)),
            ),
          ),
        ],
      ),
    );
  }
}