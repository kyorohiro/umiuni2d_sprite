part of umiuni2d_sprite;

class Rect {
  double x;
  double y;
  double w;
  double h;
  Rect(this.x, this.y, this.w, this.h) {}

  @override
  bool operator ==(o) => o is Rect && o.x == x && o.y == y && o.w == w && o.h == h;

  @override
  int get hashCode => JenkinsHash.calc([x.hashCode, y.hashCode, w.hashCode, h.hashCode]);

  @override
  String toString() {
    return "x:${x}, y:${y}, w:${w}, h:${h}";
  }
}
