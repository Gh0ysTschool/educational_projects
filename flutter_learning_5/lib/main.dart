import 'package:flutter/material.dart';
//Gh0ysT:added import of english_words
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
//state that holds and generates rnadom WordPairs
class RandomWordState extends State<RandomWord> {
  final _suggestions = <WordPair>[];
  final _font = const TextStyle(fontSize: 18.0);
  //Gh0ysT: added a set to save favorited word pairs to
  final Set<WordPair> _saved = new Set<WordPair>();  
  //Gh0ysT: method to handle display of saved WordPairs
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
      //Gh0ysT: added and ItemBuilder to be called when the ListView generates each item
      itemBuilder: (context, i){
        //Gh0ysT:  every other call will simply generate a dividing line
        if (i.isOdd) return Divider();
        //Gh0ysT: the index of the wordpair excluding the dividing lines
        final index = i ~/ 2;
        //Gh0ysT:  generate another 10 wordpairs in the end of the list has been reached
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
//container class for instantiating a state
class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}