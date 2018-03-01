part of umiuni2d_sprite;

class DisplayObject {
  String objectName = "none";
  List<DisplayObject> child = [];
  Matrix4 mat = new Matrix4.identity();
  Stage _currentStage = null;


  DisplayObject({this.child: null}) {
    if (child == null) {
      child = [];
    }
  }

  DisplayObject findObjectFromObjectName(String objectName) {
    if (this.objectName == objectName) {
      return this;
    }
    for (DisplayObject d in child) {
      DisplayObject t = d.findObjectFromObjectName(objectName);
      if (t != null) {
        return t;
      }
    }
    return null;
  }

  Future addChilds(List<DisplayObject> ds) async {
    await new Future.value();
    for(DisplayObject d in ds) {
      if(d != null) {
        child.add(d);
        //
        if(_isInit == false && _currentStage != null) {
          init(_currentStage);
        }
      }
    }
  }

  Future addChild(DisplayObject d) async {
    await new Future.value();
    child.add(d);
    if(_isInit == false && _currentStage != null) {
      init(_currentStage);
    }
  }

  Future rmChild(DisplayObject d) async {
    await new Future.value();
    child.remove(d);
    d.unattach();
  }

  Future clearChild() async {
    await new Future.value();
    for(DisplayObject d in child) {
      rmChild(d);
    }
  }

  void onChangeStageStatus(Stage stage, DisplayObject parent) {}

  void changeStageStatus(Stage stage, DisplayObject parent) {
    onChangeStageStatus(stage, parent);
    for (DisplayObject d in child) {
      d.changeStageStatus(stage, this);
    }
  }

  void onInit(Stage stage) {
    _isInit = true;
  }

  void init(Stage stage) {
    onInit(stage);
    for (DisplayObject d in child) {
      d.init(stage);
    }
  }

  void onTick(Stage stage, int timeStamp) {}

  void tick(Stage stage, DisplayObject parent, int timeStamp) {
    attachCheck(stage, parent);
    onTick(stage, timeStamp);
    for (DisplayObject d in child) {
      d.tick(stage, this, timeStamp);
    }
  }

  void onPaint(Stage stage, Canvas canvas) {}

  void paint(Stage stage, Canvas canvas) {
    onPaint(stage, canvas);
    for (DisplayObject d in child) {
      canvas.pushMulMatrix(d.mat);
      d.paint(stage, canvas);
      canvas.popMatrix();
    }
  }

  bool touch(Stage stage, DisplayObject parent, int id, StagePointerType type, double x, double y) {
    attachCheck(stage, parent);
    onTouchStart(stage, id, type, x, y);
    for(int i=0;i<child.length;i++) {
      DisplayObject d = child[child.length-(i+1)];
      stage.pushMulMatrix(d.mat);
      bool r = d.touch(stage, this, id, type, x, y);
      stage.popMatrix();
      if(r == true) {
        return r;
      }
    }

    {
      bool ret = onTouch(stage, id, type, x, y);
      onTouchEnd(stage, id, type, x, y);
      return ret;
    }
  }

  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY) => false;

  void onTouchStart(Stage stage, int id, StagePointerType type, double x, double y) {}

  void onTouchEnd(Stage stage, int id, StagePointerType type, double x, double y) {}

  void onUnattach() {
    _currentStage = null;
  }

  void unattach() {
    onUnattach();
    for (DisplayObject d in child) {
      d.unattach();
    }
    _isAttach = false;
  }

  void onAttach(Stage stage, DisplayObject parent) {
    _currentStage = stage;
  }

  void attachCheck(Stage stage, DisplayObject parent) {
    if(_isInit == false) {
      _isInit = true;
      init(stage);
    }
    if(isAttach == false) {
      _isAttach = true;
      onAttach(stage, parent);
    }
  }

  bool _isAttach = false;
  bool get isAttach => _isAttach;
  bool _isInit = false;

  //
  //
  bool checkFocus(double localX, double localY) => false;
}
