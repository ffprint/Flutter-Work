
import 'package:flutter/material.dart';
import 'dart:math' as math;
class CustomGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomGrid();
  }
}

class _CustomGrid extends State<CustomGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.live_help), onPressed: _push),
        ],
      ),
      body: buildGrid(),
    );
  }

  List<GridTile> _buildGridTileList(int count) {

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
        // color: Colors.red[100 * (index + 1)],
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 3),
          color: Color.fromARGB(180, randomColor(), randomColor(), randomColor()),
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
    print('sssssss');
  }


}