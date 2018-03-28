part of umiuni2d_sprite;


class DisplayObjectEx extends DisplayObject {

  //
  void set x(double v) {}
  void set y(double v) {}
  void set rotation(double v) {}
  void set scaleX(double v) {}
  void set scaleY(double v) {}

  //
  //
  List<ExFunc> extensions = [];
  addExtension(ExFunc ex) {
    extensions.add(ex);
  }

  removeExtension(ExFunc ex){
    extensions.remove(ex);
  }

  clearExtension() {
    extensions.clear();
  }

  @override
  void onChangeStageStatus(Stage stage, DisplayObject parent) {
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onChangeStageStatus(stage, parent);
      }
    }
  }

  @override
  void onInit(Stage stage) {
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onInit(stage);
      }
    }
  }

  @override
  void onTick(Stage stage, int timeStamp) {
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onTick(stage, timeStamp);
      }
    }
  }

  void paint(Stage stage, Canvas canvas) {
    onPaintStart(stage, canvas);
    super.paint(stage, canvas);
    onPaintEnd(stage, canvas);
  }

  @override
  void onPaintStart(Stage stage, Canvas canvas){
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onPaintStart(stage, canvas);
      }
    }
  }

  @override
  void onPaintEnd(Stage stage, Canvas canvas){
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onPaintEnd(stage, canvas);
      }
    }
  }

  @override
  void onPaint(Stage stage, Canvas canvas){
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onPaint(stage, canvas);
      }
    }
  }

  @override
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY){
    bool ret = false;
    for(ExFunc b in extensions) {
      if(b.use) {
        ret = ret || b.onTouch(stage, id, type, globalX, globalY);
      }
    }
    return ret;
  }

  @override
  void onTouchStart(Stage stage, int id, StagePointerType type, double x, double y){
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onTouchStart(stage, id, type, x, y);
      }
    }
  }

  @override
  void onTouchEnd(Stage stage, int id, StagePointerType type, double x, double y){
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onTouchEnd(stage, id, type, x, y);
      }
    }
  }

  @override
  void onUnattach() {
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onUnattach();
      }
    }
  }

  @override
  void onAttach(Stage stage, DisplayObject parent) {
    for(ExFunc b in extensions) {
      if(b.use) {
        b.onAttach(stage, parent);
      }
    }
  }
}




class ExFunc {
  DisplayObject target;
  bool use = true;
  ExFunc(this.target) {
    ;
  }
  void onChangeStageStatus(Stage stage, DisplayObject parent) {}
  void onInit(Stage stage) {}
  void onTick(Stage stage, int timeStamp) {}
  void onPaintStart(Stage stage, Canvas canvas){}
  void onPaint(Stage stage, Canvas canvas){}
  void onPaintEnd(Stage stage, Canvas canvas){}
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY){return false;}
  void onTouchStart(Stage stage, int id, StagePointerType type, double x, double y){}
  void onTouchEnd(Stage stage, int id, StagePointerType type, double x, double y){}
  void onUnattach() {}
  void onAttach(Stage stage, DisplayObject parent) {}
}