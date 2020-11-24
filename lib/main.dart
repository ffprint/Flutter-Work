import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(//MaterialApp是一种标准的移动端和web端的视觉设计语言，Flutter提供了一套丰富的Material widget
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Scaffold是Material library中提供的一个widget，它提供了默认的导航栏、标题和包含主屏幕widget树的body属性，widget树可以很复杂
      home: RandomWords(),
    );
  }
}


//实现一个stateful widget至少需要两个类
//1、一个StatefulWidget类
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordState();
}
//2、一个State类，StatefulWidget类本身是不变的，但是State类在widget生命周期中始终存在
class RandomWordState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  //_saved集合用来存储用户喜欢（收藏）的单词对，为什么用set而不用list，因为set不允许重复的值
  final _saved = Set<WordPair>(); //集合

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildCustomBody(),
    );
  }


  Widget _buildCustomBody() {
    return ListView(
      children: [
        //BoxFit.cover告诉框架，图像尽可能小，但是覆盖整个渲染框
        Image.asset('images/lake.jpg',width: 600,height: 240, fit: BoxFit.cover,),
        _titleSection(),
        _buttonSection(),
        _textSection()
      ],
    );
  }

  Widget _titleSection() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('怎么说呢，你好。', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Text('哈哈哈哈', style: TextStyle(color: Colors.grey)),
              ],
            ),            
          ),
          Icon(Icons.star, color: Colors.red),
          Text('44'),
        ],
      ),
    );
  }

  Widget _buttonSection() {
    Widget _setButton(IconData icon, String title) {
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w400, color: color)),
          ),
          
        ],
      );
    }
    return Row(
      // 等距
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _setButton(Icons.call, 'CALL'),
        _setButton(Icons.near_me, 'ROUTE'),
        _setButton(Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _textSection() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Text(
        '''Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. 
        Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. 
        A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. 
        Activities enjoyed here include rowing, and riding the summer toboggan run.''', 
        softWrap: true, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
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
      },
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

