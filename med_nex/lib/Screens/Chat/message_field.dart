import 'package:flutter/material.dart';
import 'package:med_nex/Models/message.dart';
import 'package:med_nex/Models/user.dart';

class MessageField extends StatefulWidget {
  final Message message;
  final DatabaseUser currUser;

  const MessageField({Key? key, required this.message, required this.currUser}) : super(key: key);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    if(widget.currUser.uid == widget.message.senderId){
      return Align(
        alignment: Alignment.bottomRight,
        child: Chip(
          padding: const EdgeInsets.all(8.0),
          labelPadding: const EdgeInsets.all(2.0),
          label: Text(widget.message.text, style: const TextStyle(
            color: Colors.white
          )),
          backgroundColor: Colors.tealAccent[700],
          elevation: 6.0,
        ),
      );
    }else{
      return Align(
        alignment: Alignment.bottomLeft,
        child: Chip(
          padding: const EdgeInsets.all(8.0),
          labelPadding: const EdgeInsets.all(2.0),
          label: Text(widget.message.text, style: const TextStyle(
              color: Colors.black54
          )),
          backgroundColor: Colors.grey[100],
          elevation: 6.0,
        ),
      );
    }
  }
}
