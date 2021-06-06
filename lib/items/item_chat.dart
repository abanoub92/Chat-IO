import 'package:flutter/material.dart';

import '../models/chat_model.dart';

// ignore: must_be_immutable
class ItemChat extends StatelessWidget {

  final ChatModel chatModel;
  final VoidCallback onPressed;

  ItemChat({Key key, @required this.chatModel, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  chatModel.isGroup ? Icons.groups : Icons.person,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
              title: Text(
                  chatModel.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.done_all, color: Colors.grey,),
                  SizedBox(width: 3.0,),
                  Text(
                    chatModel.currentMessage,
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                  )
                ],
              ),
              trailing: Text(chatModel.time),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 20.0),
            child: Divider(thickness: 1.0,),
          ),
        ],
      ),
    );
  }
}
