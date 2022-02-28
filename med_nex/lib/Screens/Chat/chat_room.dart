import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/chat.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/messages.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final DatabaseUser currUser;
  final Chat chat;

  const ChatRoom({Key? key, required this.currUser, required this.chat}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController controller = TextEditingController();
  late String message;

  @override
  Widget build(BuildContext context) {
    late String chatpalName;
    if(widget.currUser.isDoctor){
      chatpalName = widget.chat.patientName;
    }else{
      chatpalName = widget.chat.doctorName;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[100],
        elevation: 0.0,
        title: Text(chatpalName,
          style: TextStyle(
            color: Colors.cyanAccent[700],
          ))
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: StreamProvider<QuerySnapshot?>.value(
              value: DatabaseService().chatMessages(widget.chat),
              initialData: null,
              child: Messages(chat: widget.chat, currUser: widget.currUser,)
            )
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type...'),
                  onChanged: (val) async{
                    setState(() => message = val);
                  }),
                ),
                IconButton(
                    onPressed: () async{
                      if(message.isNotEmpty) {
                        print(message);
                        DatabaseService().createMessage(message, widget.currUser, widget.chat);
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            )
          )
        ]
      )
    );
  }
}
