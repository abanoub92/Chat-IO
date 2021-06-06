import 'package:flutter/material.dart';

import '/items/item_chat.dart';
import '/models/chat_model.dart';
import '/screens/messages_screen.dart';

class ChatsScreen extends StatefulWidget {

  static const routeName = '/chats';

  const ChatsScreen({Key key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  List<ChatModel> _list = [
    ChatModel(
        name: 'Dev stack',
        icon: 'icon',
        isGroup: false,
        time: '4:00',
        currentMessage: 'Hi Everyone'
    ),
    ChatModel(
        name: 'Kishor',
        icon: 'icon',
        isGroup: false,
        time: '10:00',
        currentMessage: 'Hi Kishor'
    ),
    ChatModel(
        name: 'Collins',
        icon: 'icon',
        isGroup: false,
        time: '15:00',
        currentMessage: 'Hi Dev Stack'
    ),
    ChatModel(
        name: 'Dev server chat',
        icon: 'icon',
        isGroup: true,
        time: '20:00',
        currentMessage: 'Hi Everyone on this group'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) => ItemChat(
          chatModel: _list[index],
          onPressed: () => Navigator.of(context).pushNamed(
              MessagesScreen.routeName,
              arguments: _list[index]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat, color: Colors.white,),
        onPressed: (){},
      ),
    );
  }
}
