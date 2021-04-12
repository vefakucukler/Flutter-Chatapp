import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String userId;
  final String conversationId;
  const ConversationScreen({Key key, this.userId, this.conversationId})
      : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _editingController = TextEditingController();
  CollectionReference _ref;
  @override
  void initState() {
    _ref = Firestore.instance
        .collection('conversations/${widget.conversationId}/messages');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -8,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://dbhub.blob.core.windows.net/elele-live/86810e25-0ad8-40e1-b5c2-28078e304297"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Vefa Küçükler"),
            )
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(child: Icon(Icons.phone), onTap: () {}),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(child: Icon(Icons.video_call), onTap: () {}),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(child: Icon(Icons.more_vert), onTap: () {}),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/assets/tema4.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: _ref.orderBy('timeStamp').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data.documents
                                .map(
                                  (document) => ListTile(
                                    title: Align(
                                        alignment: widget.userId !=
                                                document['senderId']
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                        left:
                                                            Radius.circular(5),
                                                        right: Radius.circular(
                                                            5))),
                                            child: Text(
                                              document['message'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                )
                                .toList(),
                          );
                  }),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 38,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(25))),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              child: Icon(
                            Icons.tag_faces,
                            color: Colors.grey,
                          )),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _editingController ,
                            decoration: InputDecoration(
                              hintText: "Mesajınızı Yazın...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                            child: Icon(Icons.attach_file, color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: InkWell(
                              child:
                                  Icon(Icons.camera_alt, color: Colors.grey)),
                        )
                      ],
                    ),
                  ),
                )),
                Container(
                  width: 38,
                  height: 38,
                  margin: EdgeInsets.only(right: 5, bottom: 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.send),
                        onPressed: () async{
                          await _ref.add({
                            'senderId': widget.userId,
                            'message': _editingController.text,
                            'timeStamp': DateTime.now()
                          });
                          _editingController.text='';
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
