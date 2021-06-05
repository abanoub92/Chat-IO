import 'package:flutter/material.dart';

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
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
        ],
        bottom: TabBar(
            controller: _controller,
            tabs: [
              /// camera tab to capture images and record videos
              Tab(icon: Icon(Icons.camera_alt)),

              /// chat tab to check the conversations list of chats
              Tab(text: 'Chats')
            ]
        ),
      ),
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text('Camera'),
          Text('Chats'),
        ]
      )
    );
  }
}
