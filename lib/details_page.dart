import 'package:flutter/material.dart';
class DetailsPage extends StatelessWidget {
  final String title;

  const DetailsPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final text = Text('Details of $title');
    return Scaffold(
      body: Container(
        child: Center(
          child: text,
        ),
      ),
       appBar: AppBar(title: text),
    );
  }
}