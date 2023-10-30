import 'dart:ui';

class Node {
  late List<Node> children;
  late String value;
  Offset? centroid;
  Rect? rect;
  Size? visualSize;
  Node(this.value) {
    children = <Node>[];
  }
  Node.fromJson(Map<String, dynamic> jj) {
    value = jj['value'];
    var ch = jj['children'];
    if (ch != null) {
      children = ((ch as List).map((c) => Node.fromJson(c))).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'children': children.map((c) => c.toJson()).toList(),
    };
  }
}

Node depthFirstSearch(Node node, bool Function(Node n) predicate) {
  if (node.value == "null") {
    return node;
  }
  if (predicate(node)) {
    return node;
  }
  for (var i = 0; i < node.children.length; i++) {
    final m = depthFirstSearch(node.children[i], predicate);
    if (m.value != "null") return m;
  }
  return Node("null");
}

void deleteNode(Node node, Offset pos) {
  if (node.value == "null") return;

  var foundAt = -1;
  for (var i = 0; i < node.children.length; i++) {
    if (node.children[i].rect!.contains(pos)) {
      foundAt = i;
      break;
    }
  }

  if (foundAt != -1) {
    node.children.removeAt(foundAt);
    return;
  }

  for (var i = 0; i < node.children.length; i++) {
    deleteNode(node.children[i], pos);
  }
}

