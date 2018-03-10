part of umiuni2d_sprite;


class ExBlink extends ExFunc {

  int duration;

  int _a;
  int _r;
  int _g;
  int _b;
  int _da;
  int _dr;
  int _dg;
  int _db;

  Color color;
  int t =0;
  ExBlink(DisplayObject target, {Color start:null, Color  end:null, this.duration:60}): super(target){
    if(start == null) {
      start = new Color.argb(0x22, 0xff, 0xff, 0xff);
    }
    if(end == null) {
      end = new Color.argb(0xff, 0xff, 0xff, 0xff);
    }
    _a = start.a;
    _r = start.r;
    _g = start.g;
    _b = start.b;
    _da = (end.a-start.a)~/duration;
    _dr = (end.r-start.r)~/duration;
    _dg = (end.g-start.g)~/duration;
    _db = (end.b-start.b)~/duration;

    color = new Color(start.value);
  }

  @override
  void onPaintStart(Stage stage, Canvas canvas){
    t+=1;
    if(t>= duration) {
      t =0;
    }
    canvas.pushColor(
        new Color.argb(_a+_da*t,_r+_dr*t,_g+_dg*t,_b+_db*t)
    );

  }
  @override
  void onPaintEnd(Stage stage, Canvas canvas){
    canvas.popColor();
  }
}