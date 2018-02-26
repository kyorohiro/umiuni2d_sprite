part of umiuni2d_sprite;


enum CanvasTransform { NONE, ROT90, ROT180, ROT270, MIRROR, MIRROR_ROT90, MIRROR_ROT180, MIRROR_ROT270, }

abstract class Canvas {
  void clipRect(Rect rect, {Matrix4 m: null});
  void clearClip();

  DrawingShell ds;
  Canvas(double width, double height, bool useLengthHAtCCoordinates) {
    ds = new DrawingShell(width, height, useLengthHAtCCoordinates: useLengthHAtCCoordinates);
  }

  List<Matrix4> mats = [new Matrix4.identity()];
  List<Rect> stockClipRect = [];
  List<Matrix4> stockClipMat = [];

  void drawVertexWithColor(Vertices verties, {bool hasZ:false});
  void drawVertexWithImage(Vertices verties, ImageShader imageShader);
  Vertices createVertices(List<double> positions, List<double> colors, List<int> indices,
      {List<double> cCoordinates});

  //
  //
  void setupImages(List<Image> images) {

  }

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
    ds.drawImageRect(image, src, dst, transform:transform);
  }

  void drawRect(Rect rect, Paint paint, {List<Object> cache: null}){
    ds.currentMatrix = mats.last;
    ds.drawRect(rect, paint);
  }

  clear() {
  }

  ImageShader createImageShader(Image image);
  Map<Image, ImageShader> ims = {};
  flush() {
    ds.flush();
    for(DrawingShellItem item in ds.infos) {
      if(item.flImg == null) {
        this.drawVertexWithColor(createVertices(item.flVert, item.flColor, item.flInde));
      } else {
        ImageShader s = null;
        if(ims.containsKey(item.flImg )) {
          s = ims[item.flImg ];
        } else{
          s = this.createImageShader(item.flImg);
          ims[item.flImg] = s;
        }
        this.drawVertexWithImage(createVertices(item.flVert, item.flColor, item.flInde, cCoordinates: item.flTex), s);
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

  void pushClipRect(Rect rect) {
    stockClipRect.add(rect);
    stockClipMat.add(getMatrix());
    clipRect(rect);
  }

  void popClipRect() {
    stockClipRect.removeLast();
    if (stockClipRect.length > 0) {
      clipRect(stockClipRect.last, m: stockClipMat.last);
    } else {
      clearClip();
    }
  }


//
//
}


class Vertices {

}