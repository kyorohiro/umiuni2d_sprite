part of umiuni2d_sprite;

class Joystick extends Sprite {
  @override
  String objectName = "joystick";

  double size = 50.0;
  double minWidth = 25.0;
  bool isTouch = false;
  int touchId = 0;
  double minX = 0.0;
  double minY = 0.0;
  //double releaseMinX = 0.0;
  //double releaseMinY = 0.0;
  double get directionMax => size/2;
  double get directionX {
    if(leftEventButton.isTouch) {
      return -0.9;
    } else if(rightEventButton.isTouch) {
      return 0.9;
    } else {
      return minX / minWidth;
    }
  }
  double get directionY {
    if(downEventButton.isTouch) {
      return -0.9;
    } else if(upEventButton.isTouch) {
      return 0.9;
    } else {
      return - minY/minWidth;;
    }
  }
  void saveDirectionXY() {
    directionX_saved = directionX;
    directionY_saved = directionY;
  }
//  double get directionX_released => releaseMinX/minWidth;
//  double get directionY_released => - releaseMinY/minWidth;
  double directionX_saved = 0.0;
  double directionY_saved = 0.0;

  double get directionXAbs => abs(directionX);
  double get directionYAbs =>  abs(directionY);

  bool _registerUp = false;
  bool _registerDown = false;

  bool get registerUp => (upEventButton.registerUp || downEventButton.registerUp || leftEventButton.registerUp || rightEventButton.registerUp  || _registerUp);
  bool get registerDown =>  (upEventButton.registerDown || downEventButton.registerDown || leftEventButton.registerDown || rightEventButton.registerDown  || _registerDown);


  void set registerUp(bool v) {
    _registerUp = v;
    upEventButton.registerUp = v;
    downEventButton.registerUp = v;
    leftEventButton.registerUp = v;
    rightEventButton.registerUp = v;
  }

  void set registerDown(bool v) {
    _registerDown = v;
    upEventButton.registerDown = v;
    downEventButton.registerDown = v;
    leftEventButton.registerDown = v;
    rightEventButton.registerDown = v;
  }


  double dx = 0.0;
  double dy = 0.0;
  double prevGX = 0.0;
  double prevGY = 0.0;

  KeyEventButton upEventButton;
  KeyEventButton downEventButton;
  KeyEventButton leftEventButton;
  KeyEventButton rightEventButton;

  Joystick({this.size:50.0,this.minWidth:25.0}) :super.empty(w:50.0, h:50.0){
    upEventButton = new KeyEventButton("dummy");
    downEventButton = new KeyEventButton("dummy");
    leftEventButton = new KeyEventButton("dummy");
    rightEventButton = new KeyEventButton("dummy");
  }

  clearStatus() {
    _registerUp = false;
    _registerDown = false;
    isTouch = false;
    touchId = 0;
    minX = 0.0;
    minY = 0.0;
    //releaseMinX = 0.0;
    //releaseMinY = 0.0;
  }

  @override
  void onInit(Stage stage) {
    super.onInit(stage);
    upEventButton = stage.createKeyEventButton("ArrowUp");
    downEventButton = stage.createKeyEventButton("ArrowDown");
    leftEventButton = stage.createKeyEventButton("ArrowLeft");
    rightEventButton = stage.createKeyEventButton("ArrowRight");
  }

  @override
  void onPaint(Stage stage, Canvas canvas) {
    Paint p = new Paint();
    if (isTouch) {
      p.color = new Color.argb(0xaa, 0xaa, 0xaa, 0xff);
    } else {
      p.color = new Color.argb(0xaa, 0xff, 0xaa, 0xaa);
    }
    Rect r1 = new Rect(- size / 2, - size / 2, size, size);
    Rect r2 = new Rect(minX-(minWidth/2), minY-(minWidth/2), minWidth, minWidth);
    canvas.drawOval(r1, p);
    canvas.drawOval(r2, p);
    //print("x:y=${minX-(minWidth/2)}:${minY-(minWidth/2)}  __ ${minX} ${minY}");
  }

  @override
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY) {
    super.onTouch(stage, id, type, globalX, globalY);
    Vector3 v = stage.getCurrentPositionOnDisplayObject(globalX, globalY);
    double x = v.x;
    double y = v.y;
    if (isTouch == false) {
      if (distance(x, y, 0.0, 0.0) < size) {
        _registerDown = true;
        touchId = id;
        isTouch = true;
        this.minX = x;
        this.minY = y;
        prevGX = globalX;
        prevGY = globalY;
      }
    } else {
      if (id == touchId) {
        if (type == StagePointerType.UP || type == StagePointerType.CANCEL) {
          //print("--up");
          if(isTouch) {
            _registerUp = true;
            //releaseMinX = minX;
            //releaseMinY = minY;
          }
          isTouch = false;
          this.dx = 0.0;
          this.dy = 0.0;
          this.minX = 0.0;
          this.minY = 0.0;
        } else {
          this.minX = x;
          this.minY = y;
          double d = distance(0.0, 0.0, this.minX, this.minY);
          if (d > size / 2) {
            double dd = abs(this.minX) + abs(this.minY);
            //print("--mv ${dd}");
            this.minX = size / 2 * (this.minX) / dd;
            this.minY = size / 2 * (this.minY) / dd;
          }
          //
          dx = globalX -prevGX;
          dy = globalY -prevGY;
          prevGX = globalX;
          prevGY = globalY;
        }
      }
    }
    return false;
  }

  double abs(double v) {
    return (v > 0 ? v : -1 * v);
  }

  double distance(double x1, double y1, double x2, double y2) {
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2));
  }
}