import 'package:flutter/material.dart';
import 'node.dart';

class MindMapPainter extends CustomPainter {
  final Node tree;
  MindMapPainter(this.tree);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final rectPaint = Paint()..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPaint(Paint()..color = Colors.indigo[400]);
    drawBackground(canvas, size);

    drawCells(canvas, size);
  }

  final CellW = 150.0;
  final CellH = 50.0;
  final cellPaintBorder = Paint()
    ..color = Colors.black54
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;
  final cellPaintFill = Paint()
    ..color = Colors.white54
    ..style = PaintingStyle.fill;

  final textStyle = TextStyle(fontSize: 20.0, color: Colors.black);
  final padding = 10.0;
  void drawCells(Canvas canvas, Size size) {
    final center = Offset(padding + CellW / 2.0, size.height / 2.0);
    measureCell(tree);
    drawCell(canvas, center, tree);
  }

  final displacementFactor = 0.75;
  void drawCell(Canvas canvas, Offset center, Node node) {
    if (node.value == "null") return;

    final rect = Rect.fromCenter(center: center, width: CellW, height: CellH);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(10.0));
    canvas.drawRRect(rrect, cellPaintFill);
    canvas.drawRRect(rrect, cellPaintBorder);
    node.centroid = center;
    node.rect = rect;
    drawTextCentered(canvas, center, node.value, textStyle, rect.width);

    final totalHeight = node.visualSize!.height;
    final distance = rect.width * 2.0 * displacementFactor;
    var pos = Offset(distance, -totalHeight / 2.0);
    node.children.forEach((n) {
      final sz = n.visualSize;
      final vD = Offset(0, sz!.height + padding);
      var c = center + pos + Offset(sz.width, sz.height / 2.0);
      canvas.drawLine(center + Offset(rect.width / 2.0, 0),
          c + Offset(-rect.width / 2.0, 0), cellPaintBorder);
      drawCell(canvas, c, n);
      pos += vD;
    });
  }

  Size? measureCell(Node node) {
    if (node.value == "null") return Size(0, 0);

    var subTreeSize = const Size(0, 0);
    node.children.forEach((n) {
      final sz = measureCell(n);
      subTreeSize = Size(subTreeSize.width, subTreeSize.height + sz!.height);
    });
    final count = node.children.length;
    subTreeSize =
        Size(subTreeSize.width, subTreeSize.height + (count - 1) * padding);
    final height = subTreeSize.height > CellH ? subTreeSize.height : CellH;
    node.visualSize = Size(subTreeSize.width, height);
    return node.visualSize;
  }

  TextPainter measureText(String s, TextStyle style, double maxWidth) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  paintText(Canvas canvas, TextPainter tp, Offset position) {
    tp.paint(canvas, position);
  }

  drawTextCentered(Canvas canvas, Offset position, String text, TextStyle style,
      double maxWidth) {
    final tp = measureText(text, style, maxWidth);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    paintText(canvas, tp, pos);
  }

  drawBackground(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    rectPaint.shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [0.0, 1.0],
        colors: [Color(0xff662397), Color(0xffdc6c62)]).createShader(rect);
    canvas.drawRect(rect, rectPaint);
  }
}
