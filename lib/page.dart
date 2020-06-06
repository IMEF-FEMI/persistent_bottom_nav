import 'package:flutter/material.dart';

import 'details_page.dart';

class Page extends StatelessWidget {
  final String title;

  const Page({Key key, this.title})
      : assert(title != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final text = Text(title);
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
              onPressed: () => _openDetailsPage(context), child: text),
        ),
      ),
      appBar: AppBar(
        title: text,
      ),
    );
  }

  _openDetailsPage(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DetailsPage(title: title,)));
}
