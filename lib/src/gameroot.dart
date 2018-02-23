part of umiuni2d_sprite;

class GameRoot extends DisplayObject {
  double w = 800.0;
  double h = 600.0;
  double ratioW = 1.0;
  double ratioH = 1.0;
  double radio = 1.0;
  double l = 0.0;
  double t = 0.0;
  Color backgroundColor;
  bool isClipRect;

  GameRoot(this.w, this.h, {this.backgroundColor, this.isClipRect: true}) {
    if (backgroundColor == null) {
      backgroundColor = new Color.argb(0xff, 0xee, 0xee, 0xff);
    }
  }

  void updatePosition(Stage stage, int timeStamp) {
    ratioW = (stage.w - (stage.paddingLeft + stage.paddingRight)) / w;
    ratioH = (stage.h - (stage.paddingTop + stage.paddingBottom)) / h;
    radio = (ratioW < ratioH ? ratioW : ratioH);
    t = stage.paddingTop;
    l = (stage.w - (w * radio)) / 2 + stage.paddingLeft;
    mat = new Matrix4.identity();
    mat.translate(l, t, 0.0);
    mat.scale(radio, radio, 1.0);
  }

  bool touch(Stage stage, DisplayObject parent, int id, StagePointerType type, double x, double y) {
    return super.touch(stage, parent, id, type, x, y);
  }

  void onTick(Stage stage, int timeStamp) {
    updatePosition(stage, timeStamp);
  }

  void paint(Stage stage, Canvas canvas) {
    Rect rect = new Rect(0.0, 0.0, w, h);
    if (isClipRect == true) {
      canvas.pushClipRect(rect);
    }
    super.paint(stage, canvas);
    if (isClipRect == true) {
      canvas.popClipRect();
    }
  }


  void onPaint(Stage stage, Canvas canvas) {
    Rect rect = new Rect(0.0, 0.0, w, h);
    Paint paint = new Paint();
    paint.color = backgroundColor;
    canvas.drawRect(rect, paint);
  }
}
