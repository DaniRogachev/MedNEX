import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/chat.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/chat_room.dart';

class ChatField extends StatefulWidget {
  final Chat chat;
  final DatabaseUser currUser;

  const ChatField({Key? key, required this.chat, required this.currUser}) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  String convertToString(Timestamp timestamp){
    Duration difference = Timestamp.now().toDate().difference(timestamp.toDate());
    if(difference.inDays > 0){
      return difference.inDays.toString() + " days";
    }else if(difference.inHours > 0){
      return difference.inHours.toString() + " hours";
    }else if(difference.inMinutes > 0){
      return difference.inMinutes.toString() + " minutes";
    }else{
      return "now";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    late String chatpalName;
    if(widget.currUser.isDoctor){
      chatpalName = widget.chat.patientName;
    }else{
      chatpalName = widget.chat.doctorName;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(chatpalName),
          subtitle: Text(widget.chat.lastMessage + " : " + convertToString(widget.chat.lastMessageTime)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatRoom(currUser: widget.currUser, chat: widget.chat)),
            );
          }
        )
      )

    );
  }
}
