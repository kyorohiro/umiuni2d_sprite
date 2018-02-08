part of umiuni2d_sprite;

class Point {
  double x;
  double y;
  Point(this.x, this.y) {}

  @override
  bool operator ==(o) => o is Point && o.x == x && o.y == y;

  @override
  int get hashCode => JenkinsHash.calc([x.hashCode, y.hashCode]);

  @override
  String toString() {
    return "x:${x}, y:${y}";
  }
}
