import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        home: RandomWords()
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  Widget _buildSuggestions() {
    return ListView.builder(
       padding: const EdgeInsets.all(16.0),
       itemBuilder: (context, i) {
         if (i.isOdd) return Divider();

         final index = i ~/ 2;
         if (index >= _suggestions.length) {
           _suggestions.addAll(generateWordPairs().take(10));
         }
         return _buildRow(_suggestions[index]);
       },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Names")
      ),
      body: _buildSuggestions(),
    );
  }
}