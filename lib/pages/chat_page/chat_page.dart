import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friendly_chat/widgets/chat_widget/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textControl = TextEditingController();
  bool _isComposing = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: buildTextControl(),
            ),
          ],
        ),
      );

//buildTextControl
  Widget buildTextControl() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textControl,
                onChanged: (text) {
                  setState(
                    () {
                      _isComposing = text.isNotEmpty;
                    },
                  );
                },
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                    hintText: 'Write a message...dude'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                tooltip: 'Send',
                icon: Icon(Icons.send),
                onPressed: () =>
                    _isComposing ? _handleSubmitted(_textControl.text) : null,
              ),
            ),
          ],
        ),
      );

  void _handleSubmitted(String text) {
    _textControl.clear();
    setState(
      () {
        _isComposing = false;
      },
    );
    final ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    setState(
      () {
        _messages.insert(0, message);
      },
    );
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
