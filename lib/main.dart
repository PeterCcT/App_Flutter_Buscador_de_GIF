import 'package:flutter/material.dart';
import 'package:buscador_de_gif/ui/Home_page.dart';

void main() {
  runApp(
    MaterialApp(
        title: "Buscador de gif's",
        home: Home(),
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        )),
  );
}
