import 'package:chatapp/models/conversations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversation(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);
    return ref.snapshots().map((list) => list.documents
        .map((snapshot) => Conversation.fromSnapshot(snapshot))
        .toList());
  }
}
