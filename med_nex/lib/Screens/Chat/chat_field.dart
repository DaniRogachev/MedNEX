import 'package:flutter/material.dart';
import 'package:med_nex/Models/chat.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/chat_room.dart';

class ChatField extends StatelessWidget {
  final Chat chat;
  final DatabaseUser currUser;

  const ChatField({Key? key, required this.chat, required this.currUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String chatpalName;
    if(currUser.isDoctor){
      chatpalName = chat.patientName;
    }else{
      chatpalName = chat.doctorName;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(chatpalName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatRoom(currUser: currUser, chat: chat)),
            );
          }
        )
      )

    );
  }
}
