part of umiuni2d_sprite;

class Sprite extends DisplayObjectEx {
  Image image;
  double centerX;
  double centerY;


  double _x = 0.0;
  double _y = 0.0;
  double _rotation = 0.0;
  double _scaleX = 1.0;
  double _scaleY = 1.0;
  double _spriteW;
  double _spriteH;

  double get x => _x;
  double get y => _y;
  double get rotation => _rotation;
  double get scaleX => _scaleX;
  double get scaleY => _scaleY;

  double get spriteW => _spriteW;
  double get spriteH => _spriteH;

  //
  double get w => _spriteW * scaleX;
  double get h => _spriteH * scaleY;

  //
  Color _color = new Color.argb(0xff, 0xff, 0xff, 0xff);
  Color get color => _color;

  void updateScaleW(double w, {bool isScaleY: true}) {
    scaleX = w / _spriteW;
    scaleY = scaleY;
  }

  void updateScaleH(double h, {bool isScaleX: true}) {
    scaleY = h / _spriteH;
    scaleX = scaleY;
  }

//
  bool _update = true;
  int _currentFrameID = 0;
  int get currentFrameID => _currentFrameID;
  void set currentFrameID(int v) {
    if(_dst.length < v) {
      return;
    }
    _currentFrameID = v;
    _spriteW = _dst[v].w.toDouble();
    _spriteH = _dst[v].h.toDouble();
  }
  int get numOfFrameID => _src.length;

  void set x(double v) {
    _x = v;
    _update = true;
  }

  void set y(double v) {
    _y = v;
    _update = true;
  }

  void set rotation(double v) {
    _rotation = v;
    _update = true;
  }

  void set scaleX(double v) {
    _scaleX = v;
    _update = true;
  }

  void set scaleY(double v) {
    _scaleY = v;
    _update = true;
  }

  List<Rect> _src = [];
  List<Rect> _dst = [];
  List<CanvasTransform> _trans = [];

  Sprite.empty({double w:0.0, double h:0.0, Color color}) {
    _spriteH = h;
    _spriteW = w;
    _src.add(new Rect(0.0, 0.0, w, h));
    _dst.add(new Rect(0.0, 0.0, w, h));
    _trans.add(CanvasTransform.NONE);
    _color = color;

    if (centerX == null) {
      centerX = _spriteW / 2;
    }
    if (centerY == null) {
      centerY = _spriteH / 2;
    }
  }

  Sprite.simple(this.image, {this.centerX, this.centerY, List<Rect> srcs, List<Rect> dsts, List<CanvasTransform> transforms}) {
    _spriteW = image.w.toDouble();
    _spriteH = image.h.toDouble();

    if (centerX == null) {
      centerX = _spriteW / 2;
    }
    if (centerY == null) {
      centerY = _spriteH / 2;
    }
    if (srcs != null && dsts != null && transforms != null && srcs.length == dsts.length && srcs.length == transforms.length && srcs.length > 0) {
      _src.addAll(srcs);
      _dst.addAll(dsts);
      _trans.addAll(transforms);
    } else {
      _src.add(new Rect(0.0, 0.0, image.w.toDouble(), image.h.toDouble()));
      _dst.add(new Rect(0.0, 0.0, image.w.toDouble(), image.h.toDouble()));
      _trans.add(CanvasTransform.NONE);
    }
    if(dsts.length > 0 && srcs.length > 0) {
      currentFrameID = 0;
    }
  }

  void updateMat() {
    if (_update) {
      mat.setIdentity();
      mat.translate(x, y, 0.0);
      mat.scale(scaleX, scaleY, 1.0);
      // mat.translate(centerX, centerY, 0.0);
      mat.rotateZ(rotation);
      mat.translate(-centerX, -centerY, 0.0);
      _update = false;
    }
  }

  bool checkFocus(double localX, double localY) {
    updateMat();
//    print("--${localX}:${localY}, ${image.w}:${image.h}a");
    if (0 < localX && localX < _spriteW) {
      if (0 < localY && localY < _spriteH) {
        return true;
      }
    }
    return false;
  }

  void onTick(Stage stage, int timeStamp) {
    updateMat();
  }

  void onPaint(Stage stage, Canvas canvas) {

    int id = currentFrameID;
    if (id >= _src.length) {
      id = _src.length - 1;
    }
    if(image == null) {
      canvas.drawRect(_dst[id], new Paint(color: color));
    } else {
      canvas.drawImageRect(image, _src[id], _dst[id], transform: _trans[id]);
    }

  }
}
