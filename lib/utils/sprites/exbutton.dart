part of umiuni2d_sprite;


typedef void EXButtonCallback(String id);
typedef bool EXButtonCheckFocus(double localX, double localY);

class ExButton extends ExFunc {
  bool isTouch = false;
  bool isFocus = false;
  // if release joystickm input ture;
  bool registerUp = false;
  // if down joystickm input ture;
  bool registerDown = false;
  bool exclusiveTouch;
  String buttonName;
  EXButtonCallback onTouchCallback;
  EXButtonCheckFocus handleCheckFocus;

  ExButton(DisplayObject target, this.buttonName,this.onTouchCallback,
      {this.exclusiveTouch:true, this.handleCheckFocus:null}): super(target){
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
          isTouch = true;
          isFocus = true;
          registerDown = true;
        }
        break;
      case StagePointerType.MOVE:
        if (checkFocus(x, y)) {
          ret = true;
          isFocus = true;
        } else {
          isTouch = false;
          isFocus = false;
          registerUp = true;
        }
        break;
      case StagePointerType.UP:
        if (isTouch == true && onTouchCallback != null) {
          registerUp = true;
          new Future(() {
            onTouchCallback(buttonName);
          });
        }
        isTouch = false;
        isFocus = false;
        break;
      default:
        isTouch = false;
        isFocus = false;
    }
    /*
    i++;
    if(isFocus == true) {
      print("isFocus YES ${i}");
    } else {
      print("isFocus NO ${i}");
    }*/

    if (exclusiveTouch == true) {
      return ret;
    } else {
      return false;
    }
  }

}