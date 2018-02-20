part of umiuni2d_sprite;

abstract class CanvasRoze extends Canvas {

  double get contextWidht;
  double get contextHeight;

  void drawVertexRaw(List<double> svertex, List<int> index);
  void clearClip(Stage stage);
  void clipRect(Stage stage, Rect rect, {Matrix4 m:null});

  int maxVertexTextureImageUnits = 3;
  CanvasRoze({int numOfCircleElm:16}) {
    this.numOfCircleElm = numOfCircleElm;
  }

  List<double> flVert = [];
  List<int> flInde = [];
  List<double> flTex = [];
  Image flImg = null;
  double flZ = 0.0;

  void clear() {
    flZ = -0.5;
    double r = 0.0;
    double g = 0.0;
    double b = 0.0;
    double a = 1.0;

    flVert.clear();
    flInde.clear();
    flTex.clear();
    flImg = null;
  }

  void flush() {
    if (flVert.length != 0) {
      drawVertexRaw(flVert, flInde);
      flVert.clear();
      flInde.clear();
      flTex.clear();
      flImg = null;
    }
  }

  void updateMatrix() {}

  Matrix4 cacheMatrix = new Matrix4.identity();

  Matrix4 calcMat() {
    cacheMatrix.setIdentity();
    //cacheMatrix =
    cacheMatrix.translate(-1.0, 1.0, 0.0);
    //cacheMatrix =
    cacheMatrix.scale(2.0 / contextWidht, -2.0 / contextHeight, 1.0);
    cacheMatrix = cacheMatrix * getMatrix();
    return cacheMatrix;
  }


  //
  // template drawimage
  //

  void drawImageRect(Stage stage, Image image, Rect src, Rect dst,
      {CanvasTransform transform: CanvasTransform.NONE,
        List<Object> cache: null}) {

    if (flImg != null && flImg != image) {
      flush();
    }
    flImg = image;

    double xs = src.x / flImg.w;
    double ys = src.y / flImg.h;
    double xe = (src.x + src.w) / flImg.w;
    double ye = (src.y + src.h) / flImg.h;

    switch (transform) {
      case CanvasTransform.NONE:
        flTex.addAll([xs, ys, xs, ye, xe, ys, xe, ye]);
        break;
      case CanvasTransform.ROT90:
        flTex.addAll([xs, ye, xe, ye, xs, ys, xe, ys]);
        break;
      case CanvasTransform.ROT180:
        flTex.addAll([xe, ye, xe, ys, xs, ye, xs, ys]);
        break;
      case CanvasTransform.ROT270:
        flTex.addAll([xe, ys, xs, ys, xe, ye, xs, ye]);
        break;
      case CanvasTransform.MIRROR:
        flTex.addAll([xe, ys, xe, ye, xs, ys, xs, ye]);
        break;
      case CanvasTransform.MIRROR_ROT90:
        flTex.addAll([xs, ys, xe, ys, xs, ye, xe, ye]);
        break;
      case CanvasTransform.MIRROR_ROT180:
        flTex.addAll([xs, ye, xs, ys, xe, ye, xe, ys]);
        break;
      case CanvasTransform.MIRROR_ROT270:
        flTex.addAll([xe, ye, xs, ye, xe, ys, xs, ys]);
        break;
      default:
        flTex.addAll([xs, ys, xs, ye, xe, ys, xe, ye]);
    }

    //
    //
    //
    Matrix4 m = calcMat();
    double sx = dst.x;
    double sy = dst.y;
    double ex = dst.x + dst.w;
    double ey = dst.y + dst.h;

    Vector3 ss1 = m * new Vector3(sx, sy, 0.0);
    Vector3 ss2 = m * new Vector3(sx, ey, 0.0);
    Vector3 ss3 = m * new Vector3(ex, sy, 0.0);
    Vector3 ss4 = m * new Vector3(ex, ey, 0.0);

    int b = flVert.length ~/ 8;
    /*
    double colorR = 0.0;//paint.color.r / 0xff;
    double colorG = 0.0;//paint.color.g / 0xff;
    double colorB = 0.0;//paint.color.b / 0xff;
    double colorA = 0.0;//paint.color.a / 0xff;
*/
    double colorR = 1.0;
    double colorG = 1.0;
    double colorB = 1.0;
    double colorA = 1.0;
    flVert.addAll([
      ss1.x, ss1.y, flZ, // 7
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss2.x, ss2.y, flZ, // 1
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss3.x, ss3.y, flZ, // 9
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss4.x, ss4.y, flZ, //3
      colorR, colorG, colorB, colorA, // color
      1.0
    ]);
    flZ += 0.0001;
    //b= 0;
    flInde.addAll([b + 0, b + 1, b + 2, b + 1, b + 3, b + 2]);
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

  void drawOval(Stage stage, Rect rect, Paint paint, {List<Object> cache: null}) {
    if (paint.style == PaintStyle.fill) {
      drawFillOval(stage, rect, paint);
    } else {
      drawStrokeOval(stage, rect, paint);
    }
  }

  void drawFillOval(Stage stage, Rect rect, Paint paint) {
    double cx = rect.x + rect.w / 2.0;
    double cy = rect.y + rect.h / 2.0;
    double a = rect.w / 2;
    double b = rect.h / 2;

    Matrix4 m = calcMat();
    Vector3 s = new Vector3(0.0, 0.0, 0.0);
    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;

    for (int i = 0; i < _numOfCircleElm; i++) {
      //
      int bbb = flVert.length ~/ 8;

      //
      s.x = cx;
      s.y = cy;
      s.z = flZ;
      s = m * s;
      flVert.addAll([s.x, s.y, flZ]);
      flVert.addAll([colorR, colorG, colorB, colorA]);
      flVert.addAll([-1.0]);
      flTex.addAll([0.0, 0.0]);
      //
      s.x = cx + _circleCache[i*2+0] * a;
      s.y = cy + _circleCache[i*2+1] * b;
      s.z = flZ;
      s = m * s;
      flVert.addAll([s.x, s.y, flZ]);
      flVert.addAll([colorR, colorG, colorB, colorA]);
      flVert.addAll([-1.0]);
      flTex.addAll([0.0, 0.0]);

      //
      s.x = cx + _circleCache[i*2+2] * a;
      s.y = cy + _circleCache[i*2+3] * b;
      s.z = flZ;
      s = m * s;
      flVert.addAll([s.x, s.y, flZ]);
      flVert.addAll([colorR, colorG, colorB, colorA]);
      flVert.addAll([-1.0]);
      flTex.addAll([0.0, 0.0]);

      flInde.addAll([bbb + 0, bbb + 1, bbb + 2]);

      flZ += 0.0001;
    }
  }

  void drawStrokeOval(Stage stage, Rect rect, Paint paint) {
    double cx = rect.x + rect.w / 2.0;
    double cy = rect.y + rect.h / 2.0;
    double a = (rect.w + paint.strokeWidth) / 2;
    double b = (rect.h + paint.strokeWidth) / 2;
    double c = (rect.w - paint.strokeWidth) / 2;
    double d = (rect.h - paint.strokeWidth) / 2;

    Matrix4 m = calcMat();
    Vector3 s1 = new Vector3(0.0, 0.0, 0.0);
    Vector3 s2 = new Vector3(0.0, 0.0, 0.0);
    Vector3 s3 = new Vector3(0.0, 0.0, 0.0);
    Vector3 s4 = new Vector3(0.0, 0.0, 0.0);
    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;
    for (int i = 0; i < numOfCircleElm; i++) {
      //

      //
      s1.x = cx + _circleCache[i*2+0] * c;
      s1.y = cy + _circleCache[i*2+1] * d;
      s1.z = flZ;
      s1 = m * s1;

      s2.x = cx + _circleCache[i*2+0] * a;
      s2.y = cy + _circleCache[i*2+1] * b;
      s2.z = flZ;
      s2 = m * s2;

      s3.x = cx + _circleCache[i*2+2] * a;
      s3.y = cy + _circleCache[i*2+3] * b;
      s3.z = flZ;
      s3 = m * s3;

      s4.x = cx + _circleCache[i*2+2] * c;
      s4.y = cy + _circleCache[i*2+3] * d;
      s4.z = flZ;
      s4 = m * s4;
      _innerDrawFillRect(stage, s1, s2, s4, s3, colorR, colorG, colorB, colorA);

      flZ += 0.0001;
    }
  }

  void drawRect(Stage stage, Rect rect, Paint paint, {List<Object> cache: null}) {
    flush();
    if (paint.style == PaintStyle.fill) {
      drawFillRect(stage, rect, paint);
    } else {
      drawStrokeRect(stage, rect, paint);
    }
    flush();
  }

  void drawFillRect(Stage stage, Rect rect, Paint paint,{Matrix4 m:null}) {
    if(m == null) {
      m = calcMat();
    }
    double sx = rect.x;
    double sy = rect.y;
    double ex = rect.x + rect.w;
    double ey = rect.y + rect.h;
    Vector3 ss1 = m * new Vector3(sx, sy, 0.0);
    Vector3 ss2 = m * new Vector3(sx, ey, 0.0);
    Vector3 ss3 = m * new Vector3(ex, sy, 0.0);
    Vector3 ss4 = m * new Vector3(ex, ey, 0.0);

    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;
    _innerDrawFillRect(stage, ss1, ss2, ss3, ss4, colorR, colorG, colorB, colorA);
  }

  void _innerDrawFillRect(Stage stage, Vector3 ss1, Vector3 ss2, Vector3 ss3, Vector3 ss4, double colorR, double colorG, double colorB, double colorA) {
    int b = flVert.length ~/ 8;
    flVert.addAll([
      ss1.x, ss1.y, flZ, // 7
      colorR, colorG, colorB, colorA, // color
      -1.0,
      ss2.x, ss2.y, flZ, // 1
      colorR, colorG, colorB, colorA, // color
      -1.0,
      ss3.x, ss3.y, flZ, // 9
      colorR, colorG, colorB, colorA, // color
      -1.0,
      ss4.x, ss4.y, flZ, //3
      colorR, colorG, colorB, colorA, // color
      -1.0
    ]);
    flTex.addAll([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
    flZ += 0.0001;
    flInde.addAll([b + 0, b + 1, b + 2, b + 1, b + 3, b + 2]);
  }

  void drawStrokeRect(Stage stage, Rect rect, Paint paint) {
    Matrix4 m = calcMat();
    double sx = rect.x + paint.strokeWidth / 2;
    double sy = rect.y + paint.strokeWidth / 2;
    double ex = rect.x + rect.w - paint.strokeWidth / 2;
    double ey = rect.y + rect.h - paint.strokeWidth / 2;

    Vector3 ss1 = m * new Vector3(sx, sy, 0.0);
    Vector3 sz1 = m * new Vector3(sx - paint.strokeWidth, sy - paint.strokeWidth, 0.0);
    Vector3 ss2 = m * new Vector3(sx, ey, 0.0);
    Vector3 sz2 = m * new Vector3(sx - paint.strokeWidth, ey + paint.strokeWidth, 0.0);
    Vector3 ss3 = m * new Vector3(ex, sy, 0.0);
    Vector3 sz3 = m * new Vector3(ex + paint.strokeWidth, sy - paint.strokeWidth, 0.0);
    Vector3 ss4 = m * new Vector3(ex, ey, 0.0);
    Vector3 sz4 = m * new Vector3(ex + paint.strokeWidth, ey + paint.strokeWidth, 0.0);
    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;
    _innerDrawFillRect(stage, sz1, sz2, ss1, ss2, colorR, colorG, colorB, colorA);
    _innerDrawFillRect(stage, sz2, sz4, ss2, ss4, colorR, colorG, colorB, colorA);
    _innerDrawFillRect(stage, sz4, sz3, ss4, ss3, colorR, colorG, colorB, colorA);
    _innerDrawFillRect(stage, sz3, sz1, ss3, ss1, colorR, colorG, colorB, colorA);
  }

  Matrix4 baseMat = new Matrix4.identity();



  void drawLine(Stage stage, Point p1, Point p2, Paint paint, {List<Object> cache: null}) {
    Matrix4 m = calcMat();
    double d = math.sqrt(math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2));
    double dy = -1 * paint.strokeWidth * (p2.x - p1.x) / (d * 2);
    double dx = paint.strokeWidth * (p2.y - p1.y) / (d * 2);
    double sx = p1.x;
    double sy = p1.y;
    double ex = p2.x;
    double ey = p2.y;

    Vector3 v1 = new Vector3(sx - dx, sy - dy, 0.0);
    Vector3 v2 = new Vector3(sx + dx, sy + dy, 0.0);
    Vector3 v3 = new Vector3(ex + dx, ey + dy, 0.0);
    Vector3 v4 = new Vector3(ex - dx, ey - dy, 0.0);
    v1 = m * v1;
    v2 = m * v2;
    v3 = m * v3;
    v4 = m * v4;
    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;
    _innerDrawFillRect(stage, v1, v2, v3, v4, colorR, colorG, colorB, colorA);
  }




}
