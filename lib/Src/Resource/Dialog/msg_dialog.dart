import 'package:flutter/material.dart';

class MsgDialog {
  static showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(MsgDialog),
              child: Text("OK"))
        ],
      ),
    );
  }
}
