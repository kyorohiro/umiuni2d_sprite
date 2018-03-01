part of umiuni2d_sprite;

enum StagePointerType { CANCEL, UP, DOWN, MOVE }

String toStringFromPointerType(StagePointerType type) {
  switch (type) {
    case StagePointerType.CANCEL:
      return "pointercancel";
    case StagePointerType.UP:
      return "pointerup";
    case StagePointerType.DOWN:
      return "pointerdown";
    case StagePointerType.MOVE:
      return "pointermove";
    default:
      return "";
  }
}

abstract class Stage {
  double get x;
  double get y;
  double get w;
  double get h;
  double get paddingTop;
  double get paddingBottom;
  double get paddingRight;
  double get paddingLeft;
  double get deviceRadio;


  DisplayObject get root;
  void set root(DisplayObject v);

  DisplayObject get background;
  void set background(DisplayObject v);

  DisplayObject get front;
  void set front(DisplayObject v);

  GameWidget get builder;
  bool animeIsStart = false;
  int animeId = 0;
  bool startable = false;
  bool isInit = false;


  void start();
  void stop();
  void markPaintshot();
  //

  // todo
  // must to call root.changeStageStatus(this, null);
  void updateSize(double w, double h);
  //
  void kick(int timeStamp);

  void kickPaint(Stage stage, Canvas canvas) ;

  void kickTouch(Stage stage, int id, StagePointerType type, double x, double y);

  List<Matrix4> get mats;

  pushMulMatrix(Matrix4 mat);

  popMatrix();

  Matrix4 getMatrix() ;

  double get xFromMat;
  double get yFromMat;
  double get zFromMat;
  double get sxFromMat;
  double get syFromMat;
  double get szFromMat;

  Vector3 getCurrentPositionOnDisplayObject(double globalX, double globalY) ;

}

