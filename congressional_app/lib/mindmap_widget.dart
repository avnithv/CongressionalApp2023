import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';
import 'node.dart';
import 'mindmap_painter.dart';

class MindMapWidget extends StatefulWidget {
  late final Node tree;

  @override
  _MindMapWidgetState createState() => _MindMapWidgetState();

  MindMapWidget(this.tree);
}

class _MindMapWidgetState extends State<MindMapWidget> {
  late FocusNode _node;
  bool _focused = false;
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: "Button");
    _node.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _node.removeListener(_handleFocusChange);
    _node.dispose();
    super.dispose();
  }

  final _textStyle = TextStyle(fontSize: 30.0, color: Colors.black);

  Node tree = Node("Begin Here");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Stack(children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: handleOnTapUp,
        onDoubleTapDown: handleOnDoubleTapDown,
        onLongPressEnd: handleOnLongPressEnd,
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

  void toggleEditMode(String s) {
    if (_focused) {
      _node.unfocus();
    } else {
      _controller.text = s;
      _node.requestFocus();
    }
    setState(() {
      _focused = !_focused;
    });
  }

  void handleOnLongPressEnd(LongPressEndDetails details) {
    deleteNode(tree, details.localPosition);
    setState(() {});
  }

  void handleOnDoubleTapDown(TapDownDetails details) {
    _selectedNode = depthFirstSearch(tree, (Node m) {
      final inside = m.rect!.contains(details.localPosition);
      return inside;
    });
    if (_selectedNode.value != "null") {
      toggleEditMode(_selectedNode.value);
    }
  }

  void handleOnTapUp(TapUpDetails details) {
    final n = depthFirstSearch(tree, (Node m) {
      final inside = m.rect!.contains(details.localPosition);
      return inside;
    });

    if (n.value != "null") {
      setState(() {
        n.children.add(Node("Add Text"));
      });
    }
  }

  _buildTextField() {
    if (_focused) {
      return TextField(
          controller: _controller,
          onSubmitted: handleTextFieldInput,
          focusNode: _node,
          style: _textStyle,
          decoration: InputDecoration());
    } else {
      return Container();
    }
  }

  late Node _selectedNode;
  void handleTextFieldInput(String value) {
    if (_selectedNode.value != "null") {
      _selectedNode.value = value.trim();
      _selectedNode = Node("null");
    }
    toggleEditMode("");
  }
}

AppBar appBar() {
    return AppBar(
        title: Text(
          'Organize Your Thoughts',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            
          },
            child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/Arrow - Left 2.svg',
                height: 20,
                width: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
        ),
        actions: [
          Text(
            '${MyHomePage.coins}',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                alignment: Alignment.center,
                width: 37,
                child: SvgPicture.asset(
                  'assets/icons/money.svg',
                  height: 30,
                  width: 30,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)
                ),
            ),
          ),
        ], 
      );
}
