part of umiuni2d_sprite;


typedef void EXButtonCallback(String id);
typedef bool EXButtonCheckFocus(double localX, double localY);

class ExButton extends ExFunc {
  bool _isTouch = false;
  bool _isFocus = false;
  bool _registerUp = false;
  bool _registerDown = false;
  bool isOn = false;

  bool get isFocus => _isFocus;
  bool get isTouch => ((keyEventButton!= null?keyEventButton.isTouch:false) || _isTouch);
  bool get registerUp => ((keyEventButton!= null?keyEventButton.registerUp:false) || _registerUp);
  bool get registerDown => ((keyEventButton!= null?keyEventButton.registerDown:false) || _registerDown);


  void set isFocus(bool v) {
    _isFocus = v;
  }

  void set isTouch(bool v) {
    _isTouch = v;
    if(keyEventButton != null) {
      keyEventButton.isTouch = v;
    }
  }

  void set registerUp(bool v) {
    _registerUp = v;
    if(keyEventButton != null) {
      keyEventButton.registerUp = v;
    }
  }
  void set registerDown(bool v) {
    _registerDown = v;
    if(keyEventButton != null) {
      keyEventButton.registerDown = v;
    }
  }

  bool exclusiveTouch;
  String buttonName;
  EXButtonCallback onTouchCallback;
  EXButtonCheckFocus handleCheckFocus;
  KeyEventButton keyEventButton;
  ExButton(DisplayObject target, this.buttonName,this.onTouchCallback, {
        this.exclusiveTouch:true, this.handleCheckFocus:null,
        this.isOn:false, this.keyEventButton:null}): super(target){
  }

  bool checkFocus(double localX, double localY) {
    if(handleCheckFocus == null) {
      return target.checkFocus(localX, localY);
    } else {
      return handleCheckFocus(localX, localY);
    }
  }


  //int i=0;
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY){
    Vector3 v = stage.getCurrentPositionOnDisplayObject(globalX, globalY);
    double x = v.x;
    double y = v.y;
    bool ret = false;
    switch (type) {
      case StagePointerType.DOWN:
        if (checkFocus(x, y)) {
          ret = true;
          _isTouch = true;
          _isFocus = true;
          _registerDown = true;
        }
        break;
      case StagePointerType.MOVE:
        if (checkFocus(x, y)) {
          ret = true;
          _isFocus = true;
        } else {
          _isTouch = false;
          _isFocus = false;
          _registerUp = true;
        }
        break;
      case StagePointerType.UP:
        if (_isTouch == true && onTouchCallback != null) {
          _registerUp = true;
          new Future(() {
            isOn = !isOn;
            onTouchCallback(buttonName);
          });
        }
        _isTouch = false;
        _isFocus = false;
        break;
      default:
        _isTouch = false;
        _isFocus = false;
    }

    if (exclusiveTouch == true) {
      return ret;
    } else {
      return false;
    }
  }

}