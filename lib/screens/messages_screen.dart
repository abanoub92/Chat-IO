import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '/models/chat_model.dart';
import '/items/item_message_own.dart';
import '/items/item_message_member.dart';

class MessagesScreen extends StatefulWidget {

  static const routeName = '/messages';

  const MessagesScreen({Key key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  bool _isLoaded = false;
  bool _isEmojisShow = false;

  final FocusNode _messageFocusNode = FocusNode();
  final _messageController = TextEditingController();

  ChatModel _model;
  IO.Socket socket;

  /// Connect the socket.io client to server
  void onSocketConnect(){
    socket = IO.io('http://192.168.1.12:5000', IO.OptionBuilder()  //192.168.1.124 192.168.1.12
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // disable auto-connection
        .build()
    );

    socket.connect();
    socket.emit('/test', 'Hello World!');
    socket.onConnect((_) {
      print('Connected on Mobile');
    });
    print(socket.connected);
  }

  /// build custom appbar for messaging screen
  AppBar _buildAppBar(){
    return  AppBar(
      leadingWidth: 45.0,
      titleSpacing: 0,
      title: Row(
        children: [

          /// user image
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.blueGrey,
            child: Icon(
              _model.isGroup ? Icons.groups : Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
          ),

          /// user name and last seen
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _model.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'last seen today at 12:05',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.videocam)),
        IconButton(onPressed: (){}, icon: Icon(Icons.call)),
        PopupMenuButton<String>(
          onSelected: (value) {},
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('View contact'),
              value: 'View contact',
            ),
            PopupMenuItem(
              child: Text('Media, links, and docs'),
              value: 'Media, links, and docs',
            ),
            PopupMenuItem(
              child: Text('Whatsapp web'),
              value: 'Whatsapp web',
            ),
            PopupMenuItem(
              child: Text('Search'),
              value: 'Search',
            ),
            PopupMenuItem(
              child: Text('Mute notification'),
              value: 'Mute notification',
            ),
            PopupMenuItem(
              child: Text('Wallpaper'),
              value: 'Wallpaper',
            )
          ],
        ),
      ],
    );
  }

  /// build the messages body screen
  Widget _buildMessagesBody(BuildContext context){
    return Container(
      child: WillPopScope(
        child: Stack(
          children: [
            /// list of messages
            Container(
              height: MediaQuery.of(context).size.height - 140.0,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ItemMessageOwn(),
                  ItemMessageMember(),
                ],
              ),
            ),

            /// message input and sender button
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: TextFormField(
                            controller: _messageController,
                            focusNode: _messageFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a message',
                              prefixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _messageFocusNode.unfocus();
                                    _messageFocusNode.canRequestFocus = false;

                                    _isEmojisShow = !_isEmojisShow;
                                  });
                                },
                                icon: Icon(Icons.emoji_emotions)
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.attach_file)),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt))
                                ],
                              )
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Theme.of(context).accentColor,
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.mic, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),

                  _isEmojisShow ? _buildEmojiPicker() : Container()
                ],
              ),
            )
          ],
        ),

        /// function close any sheet, popup or dialog before close screen
        onWillPop: (){
          _isEmojisShow ? setState((){ _isEmojisShow = false; }) : Navigator.of(context).pop();
          return Future.value(false);
        },
      ),
    );
  }

  /// build emoji dialog picker
  Widget _buildEmojiPicker(){
    return EmojiPicker(
      config: Config(
        columns: 7,
        emojiSizeMax: 32.0,
        buttonMode: ButtonMode.MATERIAL
      ),
      onEmojiSelected: (category, emoji) {
        setState(() {
          _messageController.text += emoji.emoji;
        });
      },
    );
  }

  /// FocusNode listener for request or change
  void onFocusNodeChanged(){
    setState(() {
      _isEmojisShow = !_isEmojisShow;
    });
  }

  @override
  void initState() {
    onSocketConnect();

    _messageFocusNode.addListener(onFocusNodeChanged);
    super.initState();
  }

  @override
  void dispose() {
    _messageFocusNode.removeListener(onFocusNodeChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_isLoaded){
      _model = ModalRoute.of(context).settings.arguments as ChatModel;
      _isLoaded = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMessagesBody(context),
    );
  }
}
