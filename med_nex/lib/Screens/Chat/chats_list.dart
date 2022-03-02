import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Models/chat.dart';

import 'chat_field.dart';

class ChatsList extends StatefulWidget {
  final DatabaseUser currUser;

  const ChatsList({Key? key, required this.currUser}) : super(key: key);

  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    final allChats = Provider.of<QuerySnapshot?>(context);
    List<Chat> chats = [];
    if(allChats != null){
      for(var chat in allChats.docs){
        if(widget.currUser.isDoctor){
          if((chat.get('patientId') == widget.currUser.uid || chat.get('doctorId') == widget.currUser.uid) && chat.get('status') == 'active'){
            chats.add(Chat(chat.id, chat.get('doctorId'), chat.get('doctorName'), chat.get('patientId'), chat.get('patientName'), chat.get('request'), chat.get('status'), chat.get('lastMessage'), chat.get('lastMessageTime'), chat.get('isRated')));
          }
        }else{
          if((chat.get('patientId') == widget.currUser.uid || chat.get('doctorId') == widget.currUser.uid)){
            chats.add(Chat(chat.id, chat.get('doctorId'), chat.get('doctorName'), chat.get('patientId'), chat.get('patientName'), chat.get('request'), chat.get('status'), chat.get('lastMessage'), chat.get('lastMessageTime'), chat.get('isRated')));
          }
        }
      }
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index){
        return ChatField(chat: chats[index], currUser: widget.currUser);
      });
  }
}
