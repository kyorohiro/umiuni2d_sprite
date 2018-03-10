part of umiuni2d_sprite;


class ExBlink extends ExFunc {

  ExBlink(DisplayObject target): super(target){
  }

  double j=0.0;
  @override
  void onPaintStart(Stage stage, Canvas canvas){
    j+=0.02;
    if(j>=1.0) {
      j=0.5;
    }
    canvas.pushColor(new Color.argb(
        (0xff*j).toInt(),
        //0x00,
        0xff,0xff,0xff));
  }
  @override
  void onPaintEnd(Stage stage, Canvas canvas){
    canvas.popColor();
  }
}