part of umiuni2d_sprite;


enum CanvasTransform { NONE, ROT90, ROT180, ROT270, MIRROR, MIRROR_ROT90, MIRROR_ROT180, MIRROR_ROT270, }

class LM {
  int index = 0;
  List<Matrix4> mats = <Matrix4>[new Matrix4.identity()];
  Matrix4 get last => mats[index];

  void add(Matrix4 mat) {
    if(index+1 < mats.length) {
      mats[index+1] = mat;
    } else {
      mats.add(mat);
    }
    ++index;
  }

  Matrix4 plus() {
    if(index+1<mats.length) {
      mats[++index].setIdentity();
    } else {
      add(new Matrix4.identity());
    }
    return mats[index];
  }

  void removeLast() {
    if(index > 0) {
      index--;
    }
  }

  void clear() {
    index = 0;
  }
}

abstract class Canvas {

  void clearClip();
  void clipVertex(Vertices vertices);
  void drawVertexWithColor(Vertices verties, {bool hasZ:false});
  void drawVertexWithImage(Vertices verties, ImageShader imageShader);
  Vertices createVertices(List<double> positions, List<double> colors, List<int> indices, {List<double> cCoordinates});
  int get maxTextureImages => 4;

  DrawingShell ds;

  Canvas(double width, double height, bool useLengthHAtCCoordinates, this.ds) {
    ds.canvas = this;
  }

  LM mats = new LM();

  List<Rect> stockClipRect = [];
  List<Matrix4> stockClipMat = [];
  List<Color> stockColors = [];


  //
  //
  void setupImages(List<Image> images) {

  }

  List<double> cache_clipRect_a1 = new List<double>(8);//[v1.x, v1.y,v2.x, v2.y, v3.x, v3.y,v4.x, v4.y];
  List<double> cache_clipRect_a2 = <double>[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];//<double>[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  List<int> cache_cliprect_a3 = new List<int>(6);//=<int>[0,1,2, 0,2,3];
  Vector3 cache_cliprect_v1 = new Vector3(0.0, 0.0, 0.0);
  Vector3 cache_cliprect_v2 = new Vector3(0.0, 0.0, 0.0);
  Vector3 cache_cliprect_v3 = new Vector3(0.0, 0.0, 0.0);
  Vector3 cache_cliprect_v4 = new Vector3(0.0, 0.0, 0.0);
  Rect cache_cliprect_rect = new Rect(0.0, 0.0, 0.0, 0.0);
  Vertices cache_cliprect_vert = null;
  Matrix4 cache_cliprect_mat = new Matrix4.identity();
  void clipRect(Rect rect, {Matrix4 m:null}) {
    if(m == null) {
      m = getMatrix();
    }
    ds.currentMatrix = m;
    m = ds.calcMat();
    if(cache_cliprect_vert != null && cache_cliprect_rect == rect && cache_cliprect_mat == m) {
      clipVertex(cache_cliprect_vert);
      return;
    }
    cache_cliprect_mat.setFrom(m);
    cache_cliprect_rect.x = rect.x; cache_cliprect_rect.y = rect.y;
    cache_cliprect_rect.w = rect.w; cache_cliprect_rect.h = rect.h;

    cache_cliprect_v1.setValues(rect.x, rect.y, 0.0);
    cache_cliprect_v2.setValues(rect.x, rect.y + rect.h, 0.0);
    cache_cliprect_v3.setValues(rect.x + rect.w, rect.y + rect.h, 0.0);
    cache_cliprect_v4.setValues(rect.x + rect.w, rect.y, 0.0);
    cache_cliprect_v1.applyMatrix4(m);
    cache_cliprect_v2.applyMatrix4(m);
    cache_cliprect_v3.applyMatrix4(m);
    cache_cliprect_v4.applyMatrix4(m);
    cache_clipRect_a1[0]=cache_cliprect_v1.x;cache_clipRect_a1[1]=cache_cliprect_v1.y;cache_clipRect_a1[2]=cache_cliprect_v2.x;cache_clipRect_a1[3]=cache_cliprect_v2.y;cache_clipRect_a1[4]=cache_cliprect_v3.x;cache_clipRect_a1[5]=cache_cliprect_v3.y;cache_clipRect_a1[6]=cache_cliprect_v4.x;cache_clipRect_a1[7]=cache_cliprect_v4.y;
    cache_cliprect_a3[0]=0;cache_cliprect_a3[1]=1;cache_cliprect_a3[2]=2;cache_cliprect_a3[3]=0;cache_cliprect_a3[4]=2;cache_cliprect_a3[5]=3;
    clipVertex(cache_cliprect_vert = createVertices(cache_clipRect_a1,cache_clipRect_a2,cache_cliprect_a3));
  }

  void drawLine(Point p1, Point p2, Paint paint, {List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.currentColor = getColor();
    ds.drawLine(p1, p2, paint);
  }

  void drawOval(Rect rect, Paint paint, {List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.currentColor = getColor();
    ds.drawOval(rect, paint);
  }

  void drawImageRect(Image image, Rect src, Rect dst, {CanvasTransform transform, Paint paint:null, List<Object> cache: null}) {
    ds.currentMatrix = mats.last;
    ds.currentColor = getColor();
    ds.drawImageRect(image, src, dst, transform:transform, paint: paint);
  }

  void drawRect(Rect rect, Paint paint, {List<Object> cache: null}){
    ds.currentMatrix = mats.last;
    ds.currentColor = getColor();
    ds.drawRect(rect, paint);
  }

  clear() {
  }

  ImageShader createImageShader(Image image);
  List<Image> _iml = [];
  Map<Image, ImageShader> _ims = {};

  ImageShader getImageShader(Image image) {
    if(_ims.containsKey(image)) {
      _iml.remove(image);
      _iml.insert(0, image);
      return _ims[image];
    }

    if(_ims.length+1 < maxTextureImages) {
      _ims[image] = createImageShader(image);
      _iml.add(image);
    } else {
      //
      Image i = _iml.removeLast();
      ImageShader s = _ims[i];
      if(s != null) {
        s.dispose();
      }
      _ims.remove(i);
      //
      _ims[image] = createImageShader(image);
      _iml.add(image);
    }
    return _ims[image];
  }

  flush() {
    ds.flush();
  }

  pushMulMatrix(Matrix4 mat) {
    //mats.add(mats.last * mat);
    Matrix4 m1 = mats.last;
    Matrix4 m2 = mats.plus();
    m2.setFrom(m1);
    m2.multiply(mat);
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

  void pushColor(Color c) {
    if(stockColors.length > 0) {
      c = new Color.mul(stockColors.last, c);
    }
    stockColors.add(c);
  }

  void popColor() {
    if(stockColors.length >0) {
      stockColors.removeLast();
    }
  }

  Color getColor() {
    if(stockColors.length > 0) {
      return stockColors.last;
    } else {
      return Color.white;
    }
  }

  //
//
}


class Vertices {

}