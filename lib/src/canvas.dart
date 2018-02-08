part of umiuni2d_sprite;


enum CanvasTransform { NONE, ROT90, ROT180, ROT270, MIRROR, MIRROR_ROT90, MIRROR_ROT180, MIRROR_ROT270, }

abstract class Canvas {
  void drawOval(Stage stage, Rect rect, Paint paint, {List<Object> cache: null});
  void drawRect(Stage stage, Rect rect, Paint paint, {List<Object> cache: null});
  void drawLine(Stage stage, Point p1, Point p2, Paint paint, {List<Object> cache: null});
  void clipRect(Stage stage, Rect rect, {Matrix4 m: null});
  void clearClip(Stage stage);
  void drawImageRect(Stage stage, Image image, Rect src, Rect dst, Paint paint, {CanvasTransform transform, List<Object> cache: null});
  //void drawText(TinyStage stage, String text, TinyRect rect, TinyPaint paint, {List<Object> cache: null});

  List<Matrix4> mats = [new Matrix4.identity()];
  List<Rect> stockClipRect = [];
  List<Matrix4> stockClipMat = [];

  clear() {
    ;
  }

  flush() {
    ;
  }

  pushMulMatrix(Matrix4 mat) {
    mats.add(mats.last * mat);
    updateMatrix();
  }

  popMatrix() {
    mats.removeLast();
    updateMatrix();
  }

  Matrix4 getMatrix() {
    return mats.last;
  }

  void updateMatrix();

  void pushClipRect(Stage stage, Rect rect) {
    stockClipRect.add(rect);
    stockClipMat.add(getMatrix());
    clipRect(stage, rect);
  }

  void popClipRect(Stage stage) {
    stockClipRect.removeLast();
    if (stockClipRect.length > 0) {
      clipRect(stage, stockClipRect.last, m: stockClipMat.last);
    } else {
      clearClip(stage);
    }
  }
//
//
}