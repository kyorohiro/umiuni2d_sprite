part of umiuni2d_sprite;

class Background extends DisplayObjectEx {
 // Color backgroundColor;
  Rect _backgroundRect = new Rect(0.0, 0.0, 400.0, 400.0);
  ExFadeTo _exfade = null;

  Background({Color backgroundColor}) {
    if (backgroundColor == null) {
      backgroundColor = new Color.argb(0xff, 0x00, 0x00, 0x00);
    }
    _exfade = new ExFadeTo(this, start:backgroundColor, end:backgroundColor);
    _exfade.stop();
    addExtension(_exfade);
  }

  void updatePosition(Stage stage, int timeStamp) {
    double w = stage.w;
    double h = stage.h;
    double radio = 1.0;
    double ratioW = 1.0;//(stage.w - (stage.paddingLeft + stage.paddingRight)) / w;
    double ratioH = 1.0;//(stage.h - (stage.paddingTop + stage.paddingBottom)) / h;
    radio = (ratioW < ratioH ? ratioW : ratioH);
    double t = stage.paddingTop;
    double l = (stage.w - (w * radio)) / 2 + stage.paddingLeft;
    this.mat = new Matrix4.identity();
    this.mat.translate(l, t, 0.0);
    //this.mat.scale(radio, radio, 1.0);

    _backgroundRect.x = 0.0;
    _backgroundRect.y = 0.0;
    _backgroundRect.w = stage.w;
    _backgroundRect.h = stage.h;
  }

  void start({Color start:null, Color end:null, int duration:60}){
    _exfade.start(start:start, end:end, duration: duration);
  }

  void stop() {
    _exfade.stop();
  }

  bool touch(Stage stage, DisplayObject parent, int id, StagePointerType type, double x, double y) {
    return super.touch(stage, parent, id, type, x, y);
  }

  void onTick(Stage stage, int timeStamp) {
    updatePosition(stage, timeStamp);
  }


  Color _cacche = new Color(0xffffffff);
  void onPaint(Stage stage, Canvas canvas) {
    Paint paint = new Paint();
    paint.color = _cacche;
    canvas.drawRect(_backgroundRect, paint);
  }
}
