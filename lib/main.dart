import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //child: new Text('Hello World'),
          //child: new Text(wordPair.asPascalCase),
          child: new RandomWords(), // Generate Stateful RandomWords
        ),
      ),
    );
  }
}

// Stateful RandomWords Widget
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

// RandomWords State. This maintains the state for the RandomWords Widget
// This class will save the generated word pairs, which will grow infinitely
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }
}