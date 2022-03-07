import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/chat.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/messages.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


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
                    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                    child: StreamProvider<QuerySnapshot?>.value(
                        value: DatabaseService().chatMessages(widget.chat),
                        initialData: null,
                        child: Messages(chat: widget.chat, currUser: widget.currUser,)
                    )
                ),
                ElevatedButton(
                    onPressed: () async {
                      await DatabaseService().finishConsultation(widget.chat);
                      Navigator.pop(context);
                    },
                    child: const Text('Finish Consultation')),
                Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.text,
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
                                controller.clear();
                              }
                            },
                            icon: const Icon(Icons.send))
                      ],
                    )
                )
              ]
          )
      );
    }else{
      chatpalName = widget.chat.doctorName;
      if(widget.chat.status == 'active'){
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
                      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                      child: Column(
                        children:<Widget>[
                          Text(widget.chat.doctorName + " has accepted your request"),
                          StreamProvider<QuerySnapshot?>.value(
                            value: DatabaseService().chatMessages(widget.chat),
                            initialData: null,
                            child: Messages(chat: widget.chat, currUser: widget.currUser,)
                          ),
                        ]
                      )
                  ),
                  Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.text,
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
                                  controller.clear();
                                }
                              },
                              icon: const Icon(Icons.send))
                        ],
                      )
                  )
                ]
            )
        );
      }else if(widget.chat.isRated){
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
                      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                      child: Column(
                          children:<Widget>[
                            Text(widget.chat.doctorName + " has accepted your request"),
                            StreamProvider<QuerySnapshot?>.value(
                                value: DatabaseService().chatMessages(widget.chat),
                                initialData: null,
                                child: Messages(chat: widget.chat, currUser: widget.currUser,)
                            ),
                          ]
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: const Chip(
                      padding: EdgeInsets.all(8.0),
                      labelPadding: EdgeInsets.all(2.0),
                      label: Text("Consultation is over", style: TextStyle(
                          color: Colors.white
                      )),
                      backgroundColor: Colors.red,
                      elevation: 6.0,
                    ),
                  )
                ]
            )
        );
      }else{
        int rating = 3;
        return AlertDialog(
          title: const Text('Rate Consultation'),
          content: Column(
            children:<Widget>[
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onRatingUpdate: (currRating) {
                  rating = currRating.toInt();
                  print(currRating);
                },
              ),
              TextButton(
                onPressed: () {
                  DatabaseService().updateRating(widget.chat.doctorId, rating, widget.chat.chatId);
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ]
          ),
        );
      }
    }
  }
}
