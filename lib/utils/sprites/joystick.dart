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
  double releaseMinX = 0.0;
  double releaseMinY = 0.0;
  double get directionMax => size/2;
  double get directionX => minX/minWidth;
  double get directionY => - minY/minWidth;
  double get directionX_released => releaseMinX/minWidth;
  double get directionY_released => - releaseMinY/minWidth;
  double get directionXAbs => abs(directionX);
  double get directionYAbs =>  abs(directionY);
  // if release joystickm input ture;
  bool registerUp = false;
  // if down joystickm input ture;
  bool registerDown = false;
  double dx = 0.0;
  double dy = 0.0;
  double prevGX = 0.0;
  double prevGY = 0.0;

  Joystick({this.size:50.0,this.minWidth:25.0}) :super.empty(){

  }

  clearStatus() {
    registerUp = false;
    registerDown = false;
    isTouch = false;
    touchId = 0;
    minX = 0.0;
    minY = 0.0;
    releaseMinX = 0.0;
    releaseMinY = 0.0;
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
    Vector3 v = stage.getCurrentPositionOnDisplayObject(globalX, globalY);
    double x = v.x;
    double y = v.y;
    if (isTouch == false) {
      if (distance(x, y, 0.0, 0.0) < size) {
        registerDown = true;
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
            registerUp = true;
            releaseMinX = minX;
            releaseMinY = minY;
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