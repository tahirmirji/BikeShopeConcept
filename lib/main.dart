import 'package:flutter/material.dart';
import 'movies_concept_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesConceptPage(),
    );
  }
}
