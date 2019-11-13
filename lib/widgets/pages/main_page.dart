import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friendly_chat/widgets/pages/chat_page/chat_page.dart';
import 'package:friendly_chat/widgets/pages/map_page/map_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Chat for Friends'),
            actions: <Widget>[
              SafeArea(
                right: true,
                child: IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GMap(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ChatPage(),
        ),
      );
}
