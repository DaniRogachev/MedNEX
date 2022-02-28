import 'package:cloud_firestore/cloud_firestore.dart';

class Chat{
  late final String chatId;
  late final String doctorId;
  late final String doctorName;
  late final String patientId;
  late final String patientName;
  late final String request;
  late final String status;
  late final String lastMessage;
  late final Timestamp lastMessageTime;

  Chat(this.chatId, this.doctorId, this.doctorName, this.patientId, this.patientName,
      this.request, this.status, this.lastMessage, this.lastMessageTime);
}