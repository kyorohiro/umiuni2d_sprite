part of umiuni2d_sprite;


enum CanvasTransform { NONE, ROT90, ROT180, ROT270, MIRROR, MIRROR_ROT90, MIRROR_ROT180, MIRROR_ROT270, }

abstract class Canvas {
  void clipRect(Stage stage, Rect rect, {Matrix4 m: null});
  void clearClip(Stage stage);
  void drawRect(Stage stage, Rect rect, Paint paint, {List<Object> cache: null});
  void drawImageRect(Stage stage, Image image, Rect src, Rect dst, {CanvasTransform transform, List<Object> cache: null});
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



enum VertexMode {
  triangles,
  triangleStrip,
  triangleFan,
}

abstract class Vertices {
    Vertices.list(
      VertexMode mode,
      List<double> positions, {
        List<double> cCoordinates,
        List<int> colors,
        List<int> indices,
      });
  }