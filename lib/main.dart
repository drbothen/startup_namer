import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
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
  final _suggestions = <WordPair>[]; // List to save suggested word pairs state
  final _saved = new Set<WordPair>(); // Saved Wordlist
  final _biggerFont = const TextStyle(fontSize: 18.0); // Var to make font bigger
  @override
  // build is the main entry into the class
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  // _buildSuggestions: This method builds the ListView that displays the suggested word pairing.
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing.
        // For odd rows, the function adds a Divider widget to visually
        // separate the entries. Note that the divider may be difficult
        // to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings in the ListView,
          // minus the divider widgets.
          final index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
  // _buildRow: This function displays each new pair in a ListTile, which allows you to make the rows more attractive
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair); // Check if already saved
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // Add heart icon to each row
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // Make Hearts tapable
      onTap: () {
        setState(() {
         if (alreadySaved) {
           _saved.remove(pair);
         }  else {
           _saved.add(pair);
         }
        });
      },
    );
  }
}