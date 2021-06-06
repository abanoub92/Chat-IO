import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/chats_screen.dart';
import 'screens/messages_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Opensans',
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff128C7E),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomeScreen(),
        ChatsScreen.routeName: (_) => ChatsScreen(),
        MessagesScreen.routeName: (_) => MessagesScreen(),
      },
    );
  }
}