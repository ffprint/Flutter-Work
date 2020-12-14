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
      child: Center(
        child: CupertinoButton(
          child: Text('Press'), 
          onPressed: (){
            print('点击了press按键');
          }
        ),
      ),
    );

  }
}