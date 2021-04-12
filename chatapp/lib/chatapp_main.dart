import 'package:chatapp/Screens/callScreen.dart';
import 'package:chatapp/Screens/cameraScreen.dart';
import 'package:chatapp/Screens/messageScreen.dart';
import 'package:chatapp/Screens/statusScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatappMain extends StatefulWidget {
  @override
  _ChatappMainState createState() => _ChatappMainState();
}

class _ChatappMainState extends State<ChatappMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    _tabController.addListener(() {
      _showMessage = _tabController.index != 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  title: Text("ChatApp"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                )
              ];
            },
            body: Column(
              children: [
                TabBar(controller: _tabController, tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.camera_alt),
                  ),
                  Tab(
                    text: "Mesajlar",
                  ),
                  Tab(
                    text: "Durumlar",
                  ),
                  Tab(
                    text: "Aramalar",
                  ),
                ]),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          CameraScreen(),
                          MessageScreen(),
                          StatusScreen(),
                          CallScreen(),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showMessage
          ? FloatingActionButton(
              backgroundColor: Color(0xff252939),
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          : null,
    );
  }
}
