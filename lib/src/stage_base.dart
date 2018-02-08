part of umiuni2d_sprite;


class StageBase {
  Stage thisStage;
  StageBase(this.thisStage) {
  }


  DisplayObject _root;
  DisplayObject get root => _root;
  void set root(DisplayObject v) {
    _root = v;
  }


  void kick(int timeStamp) {
    if (thisStage.isInit == false) {
      _root.init(thisStage);
      thisStage.isInit = true;
    }
    _root.tick(thisStage, null, timeStamp);
    //markPaint();
  }

  void kickPaint(Stage stage, Canvas canvas) {
    canvas.pushMulMatrix(root.mat);
    root.paint(stage, canvas);
    canvas.popMatrix();
  }

  void kickTouch(Stage stage, int id, StagePointerType type, double x, double y) {
    stage.pushMulMatrix(root.mat);
    root.touch(stage, null, id, type, x, y);
    stage.popMatrix();
  }

  //
  //
  List<Matrix4> mats = [new Matrix4.identity()];

  pushMulMatrix(Matrix4 mat) {
    mats.add(mats.last * mat);
    //mats.add(mat*mats.last);
  }

  popMatrix() {
    mats.removeLast();
  }

  Matrix4 getMatrix() {
    return mats.last;
  }

  double get xFromMat => this.mats.last.storage[12];
  double get yFromMat => this.mats.last.storage[13];
  double get zFromMat => this.mats.last.storage[14];
  double get sxFromMat => (new Vector3(mats.last.storage[0], mats.last.storage[4], mats.last.storage[8])).length;
  double get syFromMat => (new Vector3(mats.last.storage[1], mats.last.storage[5], mats.last.storage[9])).length;
  double get szFromMat => (new Vector3(mats.last.storage[2], mats.last.storage[6], mats.last.storage[10])).length;

  /**
   * call in onTouch
   * For x, y demention
   * if camera projection matrix, you must to check
   *    https://github.com/kyorohiro/cgame/blob/master/vectorMath/cray.h
   */
  Vector3 getCurrentPositionOnDisplayObject(double globalX, double globalY) {
    Matrix4 tmp = getMatrix().clone();
    tmp.invert();
    return tmp * new Vector3(globalX, globalY, 0.0);
  }

}
