import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation({this.id, this.name, this.profileImage, this.displayMessage});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot) {
    return Conversation(
        id: snapshot.documentID,
        name: 'Vefa',
        profileImage:
            'https://dbhub.blob.core.windows.net/elele-live/86810e25-0ad8-40e1-b5c2-28078e304297',
        displayMessage: snapshot.data['displayMessage']);
  }
}
