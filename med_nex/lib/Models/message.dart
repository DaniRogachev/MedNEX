import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  late final String messageId;
  late final String text;
  late final String senderId;
  late final String senderName;
  late final Timestamp time;
  late final bool isCurrUser;

  Message(this.messageId, this.text, this.senderId, this.senderName, this.time, this.isCurrUser);
}