import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDataSources {
 Future<Stream<List<MessageModel>>> getMessageUser({required String receiverUserId});
}

class ChatRemoteDataSourcesImpl implements ChatRemoteDataSources {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRemoteDataSourcesImpl({required this.auth, required this.firestore});

  @override
  Future< Stream<List<MessageModel>>> getMessageUser({required String receiverUserId}) async{
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }
}
