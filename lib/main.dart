import 'package:flutter/material.dart';
import 'package:zq_flutter_app/ListView.dart';
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
        primarySwatch: Colors.indigo,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Scaffold是Material library中提供的一个widget，它提供了默认的导航栏、标题和包含主屏幕widget树的body属性，widget树可以很复杂
      home: HomePage(),
    );
  }
}


//实现一个stateful widget至少需要两个类
//1、一个StatefulWidget类
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}
//2、一个State类，StatefulWidget类本身是不变的，但是State类在widget生命周期中始终存在
class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: '这是用来点击的+',
        child: Icon(Icons.airplanemode_active),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        //elevation：阴影效果大小
        elevation: 10.0,
        semanticLabel: 'ssssssss',
        child: Builder(builder: (BuildContext context){
          return ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header', style: TextStyle(color: Colors.white, fontSize: 24),),
            ),
            ListTile(
              onTap: (){
                _showSnackbar(context);
              },              
              leading: Icon(Icons.message),
              title: Text('Message', style: TextStyle(fontSize: 18),),
            ),
            ListTile(
              onTap: () => {
                _showBottomSheet(context)
              },
              leading: Icon(Icons.settings),
              title: Text('Settings', style: TextStyle(fontSize: 18),),
            ),
            ListTile(
              onTap: () => {
                print("点击了Profile")
              },
              leading: Icon(Icons.account_circle),
              title: Text('Profile', style: TextStyle(fontSize: 18),),
            ),
          ],
          );
        }),
        
      ),
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

  //底部弹窗snackBar
  void _showSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('点击了Message'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));
  }

  //底部弹出sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        height: 200.0,
        child: Image.asset('images/lake.jpg', fit: BoxFit.cover,),
      );
    });
  }

  Widget _titleSection() {
    return Container(
      //这里的 color 属性和 decoration 中的color属性冲突，不能同时存在
      // color: Colors.red,
      //margin：外部间距
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        //container的边框
        border: Border(
          // Border各个边的color属性需要是 uniform 的，否则和borderRadius属性同时设置会出现异常
          top: BorderSide(color: Colors.teal[200], width: 5, style: BorderStyle.solid),
          left: BorderSide(color: Colors.teal[200], width: 5, style: BorderStyle.solid),
          bottom: BorderSide(color: Colors.teal[200], width: 5, style: BorderStyle.solid),
          right: BorderSide(color: Colors.teal[200], width: 5, style: BorderStyle.solid)
        ),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(15),
        ),
      ),
      //padding：内部间距
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
          FavoriteWidget(),
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
        Activities enjoyed here include rowing, and riding the summer toboggan run. ''', 
        softWrap: true, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
    );
  }

  //路由推出第二页面
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CustomListView();
        },
      )
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteWidget();
  }
}

class _FavoriteWidget extends State<FavoriteWidget> {

  int _favoriteCount = 41;
  bool _isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(icon: 
            (_isFavorited 
            ? Icon(Icons.star, color: Colors.red) 
            : Icon(Icons.star_border)), 
          onPressed: _toggleFavorite),
        ),

        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );

  }
  
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

}

