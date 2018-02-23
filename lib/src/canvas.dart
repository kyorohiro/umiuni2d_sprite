part of umiuni2d_sprite;


enum CanvasTransform { NONE, ROT90, ROT180, ROT270, MIRROR, MIRROR_ROT90, MIRROR_ROT180, MIRROR_ROT270, }

abstract class Canvas {
  void clipRect(Stage stage, Rect rect, {Matrix4 m: null});
  void clearClip(Stage stage);

  DrawingShell ds;
  Canvas(double width, double height) {
    ds = new DrawingShell(width, height);
  }

  List<Matrix4> mats = [new Matrix4.identity()];
  List<Rect> stockClipRect = [];
  List<Matrix4> stockClipMat = [];

  void drawVertexWithColor(List<double> positions, List<double> colors, List<int> indices,{bool hasZ:false});
  void drawVertexWithImage(List<double> positions, List<double> cCoordinates, List<int> indices, Image img, {List<double> colors, bool hasZ:false});

  void drawLine(Point p1, Point p2, Paint paint, {List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.drawLine(p1, p2, paint);
  }

  void drawOval(Rect rect, Paint paint, {List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.drawOval(rect, paint);
  }

  void drawImageRect(Image image, Rect src, Rect dst, {CanvasTransform transform, List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.drawImageRect(image, src, dst);
  }

  void drawRect(Stage stage, Rect rect, Paint paint, {List<Object> cache: null}){
    ds.currentMatrix = mats.last;
    ds.drawRect(rect, paint);
  }

  clear() {
  }

  flush() {
    ds.flush();
    for(DrawingShellItem item in ds.infos) {
      if(item.flImg == null) {
        this.drawVertexWithColor(item.flVert, item.flColor, item.flInde);
      } else {
        this.drawVertexWithImage(item.flVert, item.flTex, item.flInde, item.flImg, colors:item.flColor);
      }
    }
    ds.infos.clear();
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

  void updateMatrix() {;}

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