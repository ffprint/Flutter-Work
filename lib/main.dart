import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zq_flutter_app/ListView.dart';
void main() {
  //debug开头的调试语句，只能在debug模式下使用
  //可视化调试布局
  // debugPaintSizeEnabled = true;
  
  // 具有基线的对象，比如文字基线，会显示出来
  // debugPaintBaselinesEnabled = true;

  //调试合成图层，true，该标志用橙色或者轮廓线标注出每个层的边界,点击时也会显示响应区域
  // debugPaintPointersEnabled = true;

  //或者使用该标志，重绘时，会是该层被一组旋转色所覆盖
  // debugRepaintRainbowEnabled = true;


  //runZoned()方法，可以给执行对象指定一个Zone，相当于一个代码执行沙箱，不同沙箱之间是隔离的。
  //沙箱是可以获取、拦截或者修改一些diamante行为，例如在Zone中可以捕获日志输出、Timer创建，微任务调度等
  //沙箱也可以捕获所有未处理的异常
  //ZoneSpecification还可以定义一些其他行为
  runZoned(()=> runApp(MyApp()), zoneSpecification: ZoneSpecification(
    print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, 'intercepted: $line');
    })
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //MaterialApp是一种标准的移动端和web端的视觉设计语言，Flutter提供了一套丰富的Material widget
    return MaterialApp(
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
      initialRoute: 'home',
      //注册路由表，可以通过路由名称来打开新路由
      routes: {
        // "new_page":(context) => NewPage(),
        // "home":(context) => MyApp(),//home路由
        // "suggestions_list":(context) => CustomListView(title: 'haiya',),//CustomListView 路由
        
      },
      
      //钩子
      //onGenerateRoute，当使用Navigatior.pushNamed()来打开命名路由时，如果指定的路由名在上面的路由表中已经注册，则会调用
      //路由表中的builder来生成路由组件；如果没有注册，就会调用onGenerateRoute来生成路由
      // onGenerateRoute: (RouteSettings settings){
      //   return MaterialPageRoute(builder: (context){
      //     String routeName = settings.name;

      //     //如果访问的路由需要登录，但当前未登录，则直接返回登录页路由
      //     //引导用户登录，其他情况正常打开路由

      //   });
      // },
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
      // drawerScrimColor: 抽屉侧边栏外部颜色
      drawerScrimColor: Colors.yellow,
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      drawer: Drawer(
        //elevation：阴影效果大小
        elevation: 10.0,
        semanticLabel: 'ssssssss',
        child: Builder(builder: (BuildContext context){
          return ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom: 10.0),
              accountName: Text('Bob', style: TextStyle(fontSize: 24, color: Colors.white,)), 
              accountEmail: Text('email: 1234567@qq.com', style: TextStyle(fontSize: 18, color: Colors.white)),
              currentAccountPicture: Container(
                // padding: EdgeInsets.only(bottom: 12.0),
                // margin: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg"),
                ),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  // child: Icon(Icons.access_time),
                  backgroundImage: NetworkImage("https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg"),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("http://b-ssl.duitang.com/uploads/item/201707/01/20170701155239_2E8zH.jpeg"),
                ),
              ],
              onDetailsPressed: (){},
              decoration: BoxDecoration(
                color: Colors.red
              ),
            ),
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text('Drawer Header', style: TextStyle(color: Colors.white, fontSize: 24),),
            // ),
            // Divider(
            //   height: 2,
            //   thickness: 2.0,
            //   indent: 0,
            //   endIndent: 0,
            //   color: Colors.blue,
            // ),
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
                _showAboutDialog(context)
              },
              leading: Icon(Icons.account_circle),
              title: Text('Profile', style: TextStyle(fontSize: 18),),
            ),
          ],
          );
        }),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer End', style: TextStyle(fontSize: 24, color: Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: true,
    );
  }


  Widget _buildCustomBody() {
    return ListView(
      children: [
        //BoxFit.cover告诉框架，图像尽可能小，但是覆盖整个渲染框
        Image.asset('images/lake.jpg',width: 600,height: 240, fit: BoxFit.cover,),
        _titleSection(),
        _buttonSection(),
        _textSection(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionChip(
             avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
             ),
             label: Text('Aaron Burr'),
             onPressed: () {
              print("If you stand for nothing, Burr, what’ll you fall for?");
             }
            ),
            ActionChip(
             avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
             ),
             label: Text('Aaron Burr'),
             onPressed: () {
              print("If you stand for nothing, Burr, what’ll you fall for?");
             }
            ),
            ActionChip(
             avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
             ),
             label: Text('Aaron Burr'),
             onPressed: () {
              print("If you stand for nothing, Burr, what’ll you fall for?");
             }
            ),
          ],
        ),
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
      //这里可以放其他自定义widget
      return Container(
        height: 200.0,
        child: Image.asset('images/lake.jpg', fit: BoxFit.cover,),
      );
    });
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationVersion: '2.0.1',
      applicationIcon: Icon(Icons.accessibility),
      applicationName: 'you app',
    );
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
          top: BorderSide(color: Colors.teal[200], width: 10, style: BorderStyle.solid),
          left: BorderSide(color: Colors.teal[200], width: 10, style: BorderStyle.solid),
          bottom: BorderSide(color: Colors.teal[200], width: 10, style: BorderStyle.solid),
          right: BorderSide(color: Colors.teal[200], width: 10, style: BorderStyle.solid)
        ),

        // BorderDirectional：可以单独分开设置四个边框
        // BorderDirectional(
        //   start: BorderSide(
        //     color: Colors.red,
        //     width: 10.0,
        //   ),
        //   end: BorderSide(
        //     color: Colors.cyan,
        //     width: 10.0
        //   ),
        // ),
        
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
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
        Activities enjoyed here include rowing, and riding the summer toboggan run.''', 
        softWrap: true, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
    );
  }

  //路由推出第二页面
  void _pushSaved() {
    //这个方法会打印出widget树的结构
    // debugDumpApp();

    //这个方法打印渲染树
    // debugDumpRenderTree();

    //打印Layer树，可以理解为渲染树的一层
    // debugDumpLayerTree();

    //语义树（呈现给系统可访问性API的树）
    // debugDumpSemanticsTree();

    //调度，帧
    // debugPrintBeginFrameBanner; //帧开始事件发生的位置 bool
    // debugPrintEndFrameBanner; //帧结束时间发生的位置 bool

    Navigator.of(context).push(
      //MaterialPageRoute，表示占有整个屏幕空间的一个模态路由页面，还定义了路由构建及切换时过渡动画的相关接口及属性
      //不同平台切换表现不一样,如果想要自定义路由切换，可以自己继承 PageRoute 来实现
      MaterialPageRoute(
        //ios下，从下面弹出页面
        fullscreenDialog: true,
        //默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源可以设置为false
        maintainState: true,
        builder: (context) {
          return CustomListView(
            //路由传值
            title: 'Suggestions 列表',
          );
        },
      )
    );

    // Navigator.pushNamed(context, 'suggestions_list');

  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteWidget();
  }
}

class _FavoriteWidget extends State<FavoriteWidget> {

  int _favoriteCount = 0;
  bool _isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0.0),
          child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: Text('$_favoriteCount',style: TextStyle(fontSize: 20),),
          )
        ),
          // RaisedButton(
          //   child: const Text('+1'),
          //   onPressed: () {
          //     setState(() {
          //       _favoriteCount += 1;
          //     });
          //   },
          // )
        //   IconButton(icon: 
        //     (_isFavorited 
        //     ? Icon(Icons.star, color: Colors.red) 
        //     : Icon(Icons.star_border)), 
        //   onPressed: _toggleFavorite),
        // ),
        
        SizedBox(
          width: 30,
          child: Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: Text('$_favoriteCount', style: TextStyle(fontSize: 20)),
            ),
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

