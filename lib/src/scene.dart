part of umiuni2d_sprite;

class Scene extends DisplayObject {
  Color _beginColor;
  Color _endColor;
  Color _currentColor;

  int _duration;

  // duration is milliseconds
  Scene({Color begineColor: null, Color endColor: null, int duration}) {
    _duration = duration;

    if (begineColor == null) {
      _beginColor = Color.white;
    } else {
      _beginColor = begineColor;
    }
    _currentColor = new Color(_beginColor.value);

    if (endColor == null) {
      _endColor = _beginColor;
      _duration = 0;
    } else {
      _endColor = endColor;
    }
  }

  int _beginTImeStamp = 0;

  void onTick(Stage stage, int timeStamp) {
    if (_beginTImeStamp == 0) {
      _beginTImeStamp = timeStamp;
    }
    int t = timeStamp - _beginTImeStamp;
    if (_duration > t) {
      double da =
          (_endColor.af - _beginColor.af) * (t / _duration) + _beginColor.af;
      double dr =
          (_endColor.rf - _beginColor.rf) * (t / _duration) + _beginColor.rf;
      double dg =
          (_endColor.gf - _beginColor.gf) * (t / _duration) + _beginColor.gf;
      double db =
          (_endColor.bf - _beginColor.bf) * (t / _duration) + _beginColor.bf;
      _currentColor.value = 0;
      _currentColor.value |= ((da*0xff).toInt() & 0xff) << 24;
      _currentColor.value |= (dr*0xff).toInt() << 16;
      _currentColor.value |= (dg*0xff).toInt() << 8;
      _currentColor.value |= (db*0xff).toInt() << 0;
      print(">> ${_currentColor} ${da} ${ (da*0xff).toInt() << 24}");
    } else {
      _currentColor = _endColor;
    }
  }

  void paint(Stage stage, Canvas canvas) {
    canvas.pushColor(_currentColor);
    super.paint(stage, canvas);
    canvas.popColor();
  }
}
