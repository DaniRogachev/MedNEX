import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/chat.dart';
import 'package:med_nex/Models/message.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/message_field.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  final Chat chat;
  final DatabaseUser currUser;

  const Messages({Key? key, required this.chat, required this.currUser}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final chatMessages = Provider.of<QuerySnapshot?>(context);
    List<Message> messages = [];
    if(chatMessages != null){
      for(var message in chatMessages.docs){
        if(message.get('senderId')==widget.currUser.uid){
          messages.add(Message(message.id, message.get('message'), message.get('senderId'), message.get('senderName'), message.get('time'), true));
        }else{
          messages.add(Message(message.id, message.get('message'), message.get('senderId'), message.get('senderName'), message.get('time'), false));
        }
      }
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index){
        return MessageField(message: messages[index], currUser: widget.currUser);
      }
    );
  }
}
