import 'package:chatapp/core/services/firestore_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatapp/models/conversations.dart';
import 'package:get_it/get_it.dart';

class ChatsModel with ChangeNotifier {
  final FirestoreDB _db = GetIt.instance<FirestoreDB>();
    Stream < List <Conversation>> conversations(String userId){
      return _db.getConversation(userId);
    }

}