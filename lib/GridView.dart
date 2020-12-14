
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:zq_flutter_app/CupertinoPage.dart';
class CustomGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomGrid();
  }
}

class _CustomGrid extends State<CustomGrid> {

  //定义一个globalkey，保持全局唯一性，使用静态变量存储
  //注意：使用global开销较大，应该尽量避免使用
  static GlobalKey<ScaffoldState> _globalKey= GlobalKey();

  //当widget第一次插入到widget树时会被调用，每一个State对象，只会调用一次，通常在这里做一次性操作，例如初始化，订阅子树的时间通知
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  //当widget重新构建时，Flutter框架会调用widget.canUpdate来检测widget树中同一位置的新旧节点
  //然后决定是否需要更新，如果该函数返回true就会调用此回调（事实上widget.canUpdate会在新旧widget的key和runtimeType同事相等时返回true）
  @override
  void didUpdateWidget(covariant CustomGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  //当state对象从树中杯移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  //当state对象从树中被永久移除时调用，通常在这里释放资源
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  //点击⚡️按钮热重载会触发reassemble
  //专门为开发调试提供的,在release模式下不会被调用
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  //widge树中，如果节点的父级结构中的层级或者父级结构中的任意节点的widget类有变化，节点会调用didchangeDependencies
  //若仅仅是父级结构某一节点的widget的某些属性发生变化，节点不会调用didChangeDependencies
  //(widget结构发生变化会触发，属性变化不会触发)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  //构建widget子树,会在如下场景被调用
  //调用initState()后
  //调用didUpdateWidget()后
  //调用setState()后
  //调用didChangeDependencies()后
  //在State对选哪个从书中一个位置移除后（会调用deactivate）又重新插入到树的其他位置之后
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.live_help), onPressed: _push),
        ],
        //设置key
        key: _globalKey,
      ),
      body: buildGrid(),

      //每个widget都对应一个context对象，提供了从当前widget开始想上遍历widget树以及按照widget类型查找父级widgte的方法
      // context这里的context上下文，表示父widget，这里也就是父级Scaffold
      // body: Builder(builder: (context){
      //   Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
      // 直接返回 AppBar的title，此处时机上是Text('Grid')
      //   return (scaffold.appBar as AppBar).title;
      // }),
    );
  }

  List<GridTile> _buildGridTileList(int count) {
    //根据globalKey获取State对象
    print(_globalKey.currentState);

    int randomColor() {
      return 0 + math.Random().nextInt(256);
    }

    //生成一个list，作为数据源
    // return List<Container>.generate(count, (index) => 
    //   Container(
    //     // color: Colors.red[100 * (index + 1)],
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //     border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 5),
    //     color: Color.fromARGB(200, randomColor(), randomColor(), randomColor()),
    //   ),
    // ));

    return List<GridTile>.generate(count, (index) => 
      GridTile(
        footer: GridTileBar(
          title: Text('你好啊!!', style: TextStyle(color: Color.fromARGB(200, randomColor(), randomColor(), randomColor()), fontSize: 15, fontStyle: FontStyle.italic),),
          subtitle: Text('副标题'),
          trailing: Icon(Icons.star),
          backgroundColor: Color.fromARGB(50, randomColor(), randomColor(), randomColor()),
        ),
        child: Container(
          child: GestureDetector(
            onTap: (){
              setState(() {
                print('点击了第$index个网格');
              });
            },
          ),
        // color: Colors.red[100 * (index + 1)],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 3),
            color: Color.fromARGB(180, randomColor(), randomColor(), randomColor()
          ),
          
        ),
        // footer: GridTileBar(
        //   title: Text('你好你好你好'),
        // ),
      ),
    ));

  }

  Widget buildGrid() {
    // extent：使用maxCrossAxisExtent像素来确定一行多少个网格
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(9), 
    );

    //count：直接指定纵向模式下的行数
    // return GridView.count(
    //   crossAxisCount: 5,
    //   mainAxisSpacing: 4,
    //   crossAxisSpacing: 4,
    //   children: _buildGridTileList(10),
    //   );
  }

  void _push() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return CupertinoPage();
        },
      )
    );
  }


}