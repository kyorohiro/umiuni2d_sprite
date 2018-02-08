part of umiuni2d_sprite;

enum PaintStyle { fill, stroke }

class Paint {
  Color color;
  PaintStyle style = PaintStyle.fill;
  double strokeWidth = 1.0;
  Paint({this.color}) {
    if (this.color == null) {
      color = new Color.argb(0xff, 0xff, 0xff, 0xff);
    }
  }
}
