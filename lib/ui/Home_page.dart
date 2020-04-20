import 'dart:convert';

import 'package:buscador_de_gif/ui/gif_pag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  int _offset = 0;
  List<Image> gifs = [];

  ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    _scroll.addListener(
      () {
        if (_scroll.offset >= _scroll.position.maxScrollExtent) {
          setState(() {
            _offset += 10;
          });
        }
      },
    );
  }

  Future<Map> _getGif() async {
    http.Response response;
    _search == null || _search.isEmpty
        ? response = await http.get(
            "https://api.giphy.com/v1/gifs/trending?api_key=3iWCUqFWztfhFCv5E2pCTxzWWNvrHD7Z&limit=20&rating=G")
        : response = await http.get(
            "https://api.giphy.com/v1/gifs/search?api_key=3iWCUqFWztfhFCv5E2pCTxzWWNvrHD7Z&q=$_search&limit=20&offset=$_offset&rating=G&lang=pt");

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
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGif(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case (ConnectionState.waiting):
                  case (ConnectionState.none):
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 5,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _gifTable(context, snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _count(List dados) {
    if (_search == null)
      return dados.length;
    else
      return dados.length + 1;
  }

  Widget _gifTable(context, snapshot) {
    return GridView.builder(
      controller: _scroll,
      padding: EdgeInsets.all(5),
      itemCount: _count(snapshot.data["data"]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data["data"].length)
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              fit: BoxFit.cover,
              height: 300,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]),
                ),
              );
            },
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"]);
            },
          );
        else
          return Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.ac_unit),
              ],
            ),
          );
      },
    );
  }
}
