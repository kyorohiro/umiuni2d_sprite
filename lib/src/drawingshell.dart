//
// use http://sapphire-al2o3.github.io/font_tex/
//
part of umiuni2d_sprite;


abstract class DrawingShell {
  Matrix4 currentMatrix = new Matrix4.identity();
  Color currentColor = new Color(0xffffffff);

  Matrix4 cacheMatrix = new Matrix4.identity();
  double contextWidht;
  double contextHeight;

  bool useLengthHAtCCoordinates;
  Canvas canvas;
  DrawingShell(this.contextWidht, this.contextHeight, { this.useLengthHAtCCoordinates:false}) {
    numOfCircleElm = 20;
  }

  void clear() {}

  void flush() {}


  Matrix4 calcMat() {
    cacheMatrix.setIdentity();
    cacheMatrix.translate(-1.0, 1.0, 0.0);
    cacheMatrix.scale(2.0 / contextWidht, -2.0 / contextHeight, 1.0);
    cacheMatrix = cacheMatrix * getMatrix();
    return cacheMatrix;
  }

  Matrix4 getMatrix() {
    return currentMatrix;
  }


  //
  //
  // template
  //
  //

  int _numOfCircleElm;
  int get numOfCircleElm => _numOfCircleElm;
  List<double> _circleCache = [];

  void set numOfCircleElm(v) {
    _numOfCircleElm = v;
    for (int i = 0; i < _numOfCircleElm+1; i++) {
      _circleCache.add(math.cos(2 * math.PI * (i / _numOfCircleElm)));
      _circleCache.add(math.sin(2 * math.PI * (i / _numOfCircleElm)));
    }
  }


  void drawOval(Rect rect, Paint paint, {List<Object> cache: null});
  void drawFillOval(Rect rect, Paint paint);
  void drawStrokeOval(Rect rect, Paint paint);
  void drawRect(Rect rect, Paint paint, {List<Object> cache: null});
  void drawFillRect(Rect rect, Paint paint,{Matrix4 m:null});
  void drawStrokeRect(Rect rect, Paint paint);
  void drawLine(Point p1, Point p2, Paint paint, {List<Object> cache: null});
  void drawImageRect(Image image, Rect src, Rect dst,
      {CanvasTransform transform: CanvasTransform.NONE,Paint paint:null,
        List<Object> cache: null});
}
