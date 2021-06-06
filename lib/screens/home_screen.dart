import 'package:flutter/material.dart';

import './chats_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  /// controller the tabs of tabBar
  TabController _controller;
  
  @override
  void initState() {
    /// initialize the controller with the count of tabs, listener and begin tab
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat IO'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('Selected menu item $value');
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('New group'),
                value: 'New group',
              ),
              PopupMenuItem(
                child: Text('New broadcast'),
                value: 'New broadcast',
              ),
              PopupMenuItem(
                child: Text('Whatsapp web'),
                value: 'Whatsapp web',
              ),
              PopupMenuItem(
                child: Text('Starred messages'),
                value: 'Starred messages',
              ),
              PopupMenuItem(
                child: Text('Settings'),
                value: 'Settings',
              )
            ],
          ),
        ],
        bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: [
              /// camera tab to capture images and record videos
              Tab(icon: Icon(Icons.camera_alt)),

              /// chat tab to check the conversations list of chats
              Tab(text: 'CHATS')
            ]
        ),
      ),
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text('Camera'),
          ChatsScreen()
        ]
      )
    );
  }
}
