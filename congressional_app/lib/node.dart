import 'dart:ui';

class Node {
  List<Node> children;
  String value;
  Offset centroid;
  Rect rect;
  Size visualSize;
  Node(this.value) {
    children = List<Node>();
  }
}


Node depthFirstSearch(Node node, bool Function(Node n) predicate) {
  if (node == null) {
    return node;
  }
  if (predicate(node)) return node;
  for (var i = 0; i < node.children.length; i++) {
    final m = depthFirstSearch(node.children[i], predicate);
    if (m != null) return m;
  }
  return null;
}
