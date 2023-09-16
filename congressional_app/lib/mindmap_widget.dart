import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mindmap/node.dart';

import 'mindmap_painter.dart';

class MindMapWidget extends StatefulWidget {
  @override
  _MindMapWidgetState createState() => _MindMapWidgetState();
}

class _MindMapWidgetState extends State<MindMapWidget> {
  FocusNode _node;
  bool _focused = false;
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _handleFocusChange() {}

  @override
  void dispose() {
    super.dispose();
  }

  final _textStyle = TextStyle(fontSize: 30.0, color: Colors.black);

  Node tree = Node("Begin Here");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: handleOnTapUp,
        onTap: HandleonTap,
        onDoubleTapDown: handleDoubleTapDown,
        onDoubleTap: handOnDoubleTap,
        onLongPressEnd: handLongPressEnd,
        child: CustomPaint(
          child: Container(),
          painter: MindMapPainter(tree),
        ),
      ),
      SizedBox(height: 100),
      Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildTextField(),
            ],
          ),
        ),
      )
    ]));
  }
}

