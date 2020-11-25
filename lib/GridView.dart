
import 'package:flutter/material.dart';

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

  List<Container> _buildGridTileList(int count) {
    //生成一个list，作为数据源
    return List<Container>.generate(count, (index) => 
      Container(
        color: Colors.red[100 * (index + 1)],
      ),
    );
  }

  Widget buildGrid() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(10), 
    );
  }

  void _push() {
    print('sssssss');
  }


}