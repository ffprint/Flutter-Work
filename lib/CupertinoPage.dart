import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoPageState();
  }
}

class _CupertinoPageState extends State<CupertinoPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demo'),
      ),
      child: ListView(
        children: [
          TapboxA(),
          ParentWidget(),
          ParentWidgetC(),
        ],
      ),
    );

  }
}


// TapboxA 管理自身状态.
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.blueGrey,
        ),
        child: Center(
          child: Text(
            _active ? 'BoxA-Active' : 'BoxA-Inactive',
            //如果根节点不是Material组件，就会默认带上下划线，需要手动设置 decoration 为 none
            style: TextStyle(fontSize: 25.0, color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}


//TapboxB类：ParentWidget为TapboxB管理状态
class ParentWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ParentWidget();
  }
}

class _ParentWidget extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {

  TapboxB({Key key, this.active: false, @required this.onChanged}) 
  : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.blueGrey,
        ),
        child: Center(
          child: Text(
            active ? 'BoxB-Active' : 'BoxB-Inactive',
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          ),
        ),
      ),
    );

  }
}


//TapboxC 混合状态管理
//一部分状态父widget管理，一部分状态自身管理
class ParentWidgetC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}


class TapboxC extends StatefulWidget {

  TapboxC({Key key, this.active: false, @required this.onChanged})
  : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _TapboxCState(); 
  }
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border:_highlight ? Border.all(
            color: Colors.teal[700],
            width: 10.0
          ): null,
        ),
        child: Center(
          child: Text(
            widget.active ? 'BoxC-Active':'BoxC-Inactive', 
            style: TextStyle(fontSize: 25, color: Colors.white) 
          ),),
        ),
      );
  }
}

//全局状态管理：
//例如：设置语言，全app生效，这时可以通过一个全局状态管理来处理这种各个widget较分散、距离较远的问题
/*
  1、实现一个全局的时间总线，将语言状态改变对应为一个时间，然后在app中依赖应用语言的组件的initState方法中
  订阅语言改变的时间，当用户切换语言后，发布语言改变事件，订阅了该时间的组件就会收到通知，然后调用setState方法
  重新build一下即可

  2、使用一些专门用于状态管理的包，如Provider、Redux等
*/