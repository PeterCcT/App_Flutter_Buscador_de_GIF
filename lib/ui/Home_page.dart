import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  int _offset = 0;
  Future<Map> _getGif() async {
    http.Response response;
    _search == null
        ? response = await http.get(
            "https://api.giphy.com/v1/gifs/trending?api_key=3iWCUqFWztfhFCv5E2pCTxzWWNvrHD7Z&limit=10&rating=G")
        : response = await http.get(
            "https://api.giphy.com/v1/gifs/search?api_key=3iWCUqFWztfhFCv5E2pCTxzWWNvrHD7Z&q=$_search&limit=30&offset=$_offset&rating=G&lang=pt");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Just some gif's",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Gif's",
                labelStyle: TextStyle(
                    fontSize: 16, color: Colors.white, letterSpacing: 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: TextStyle(
                  fontSize: 16, color: Colors.white, letterSpacing: 3),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
