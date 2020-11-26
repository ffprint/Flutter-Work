
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:zq_flutter_app/GridView.dart';


class CustomListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomListViewState();
  }
}

class _CustomListViewState extends State<CustomListView> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  //_saved集合用来存储用户喜欢（收藏）的单词对，为什么用set而不用list，因为set不允许重复的值
  final _saved = Set<WordPair>(); //集合

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions List'),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            //生成10个单词对，然后添加到列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        //setState()，会为State对象触发 build() 方法,进而导致UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
        _pushGrid();
      },
    );
  }

  void _pushGrid() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CustomGrid();
        },
      )
    );
  }

  //路由推出第二页面
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair){
            return ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            );
          });

          final divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );

        },
      )
    );
  }


}