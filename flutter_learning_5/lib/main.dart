import 'package:flutter/material.dart';
//Gh0ysT:added import of english_words
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWord() 
    );
  }
}
class RandomWordState extends State<RandomWord> {
  final _suggestions = <WordPair>[];
  final _font = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();  
  void _pushedSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair){
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _font,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _font,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState((){
          if (alreadySaved){
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }
  
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Pair Generator"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushedSaved),
        ],
      ),
      body: _buildSuggestions(),
    ) ; 
  }
}
class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}