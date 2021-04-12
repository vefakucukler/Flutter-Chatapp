import 'package:chatapp/Screens/conversationScreen.dart';
import 'package:chatapp/models/conversations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/viewModels/chats_model.dart';

class MessageScreen extends StatelessWidget {
  final String userId = "tujUeGSZk4ful2OVKzz3eg6YImR2";
  const MessageScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    return ChangeNotifierProvider(
          create: (BuildContext context) => model,
          child: StreamBuilder<List<Conversation>>(
          stream:model.conversations(userId),
          builder: (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
            if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            return ListView(
              children: snapshot.data
                  .map((doc) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doc.profileImage),
                        ),
                        title: Text(doc.name),
                        subtitle: Text(doc.displayMessage),
                        trailing: Column(children: <Widget>[
                          Text("19:30"),
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentColor),
                            child: Center(
                              child: Text(
                                "7",
                                textScaleFactor: 0.7,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => ConversationScreen(
                                        userId: userId,
                                        conversationId: doc.id,
                                      )));
                        },
                      ))
                  .toList(),
            );
          }),
    );
  }
}
