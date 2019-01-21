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
      //Gh0ysT: removed MyApp and replaced it with a Scaffold
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Flutter")
        ),
        body: Center(
          child: RandomWord() 
        )
      )
    );
  }
}
//state that holds and generates rnadom WordPairs
class RandomWordState extends State<RandomWord> {
  @override
  Widget build(BuildContext context){
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);    
  }
}
//container class for instantiating a state
class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}