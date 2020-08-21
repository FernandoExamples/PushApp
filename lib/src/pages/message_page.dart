import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('MessagePage'),
      ),
      body: Center(
        child: Text(arg),
      ),
    );
  }
}
