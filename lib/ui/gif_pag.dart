import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  final Map _dadosGif;

  GifPage(this._dadosGif);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dadosGif["title"]),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_dadosGif["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
