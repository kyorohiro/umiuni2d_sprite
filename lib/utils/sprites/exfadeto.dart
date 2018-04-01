part of umiuni2d_sprite;

class ExFadeTo extends ExFunc {

  int _duration;

  int _a;
  int _r;
  int _g;
  int _b;
  int _da;
  int _dr;
  int _dg;
  int _db;

  Color _color;
  Color _start;
  Color _end;

  int _time =0;
  bool isStart = true;

  ExFadeTo(DisplayObject target, {Color start:null, Color  end:null, int duration:60}): super(target){
    this.start(start:start, end:end, duration:duration);
  }

  void start({Color start:null, Color  end:null, int duration:60}){
    this.isStart = true;
    this._time = 0;
    this._duration = duration;
    if(start == null) {
      if(_color == null) {
        start = new Color.argb(0x22, 0xff, 0xff, 0xff);
      } else {
        start = _color;
      }
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

    _start = start;
    _end = end;
    _color = new Color(start.value);
  }

  void stop() {
    this.isStart = false;
  }

  @override
  void onPaintStart(Stage stage, Canvas canvas){
    if(isStart == true) {
      if (_time >= _duration) {
        _time = _duration;
      } else {
        _time += 1;
      }
    } else {
      _time = _duration;
    }
    if(_duration < _time) {
      _color = new Color.argb(
          _a + _da * _time, _r + _dr * _time, _g + _dg * _time,
          _b + _db * _time);
      canvas.pushColor(_color);
    } else {
      canvas.pushColor(_end);
    }
  }

  @override
  void onPaintEnd(Stage stage, Canvas canvas){
    canvas.popColor();
  }
}