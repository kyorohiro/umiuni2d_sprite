part of umiuni2d_sprite;

class GameController01 extends Scene {

  GameWidget builder;
  Paint p = new Paint();

  Joystick joystick;
  ExDrag joystickExDrag;

  Sprite buttonL;
  ExButton buttonLEx;
  ExDrag buttonLExDrag;

  Sprite buttonR;
  ExButton buttonREx;
  ExDrag buttonRExDrag;

  Sprite buttonStop;
  ExButton buttonStopEx;

  bool _isStop = false;

  GameController01():super(
      begineColor:new Color(0x00ffffff),
      endColor:new Color(0xffffffff),
      duration:1000);

  @override
  void onInit(Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    // L
    buttonL = new Sprite.empty(w:200.0,h:200.0,color:new Color.argb(0xaa, 0xaa, 0xaa, 0xff));
    buttonL.addExtension(buttonLEx= new ExButton(buttonL, "l", (String l){}));
    buttonL.addExtension(buttonLExDrag = new ExDrag(buttonL));
    buttonLExDrag.use = false;
    // R
    buttonR = new Sprite.empty(w:200.0,h:200.0,color:new Color.argb(0xaa, 0xaa, 0xff, 0xaa));
    buttonR.addExtension(buttonREx= new ExButton(buttonL, "r", (String l){}));
    buttonR.addExtension(buttonRExDrag= new ExDrag(buttonR));
    buttonRExDrag.use = false;

    // S
    buttonStop = new Sprite.empty(w:200.0,h:50.0,color:new Color.argb(0xaa, 0xff, 0x88, 0x88));
    buttonStop.addExtension(buttonStopEx= new ExButton(buttonL, "s", (String l){
      _isStop = (_isStop?false:true);
      if(_isStop) {
        buttonREx.use = false;
        buttonLEx.use = false;

        buttonRExDrag.use = true;
        buttonLExDrag.use = true;
        joystickExDrag.use = true;

      } else {
        buttonREx.use = true;
        buttonLEx.use = true;

        buttonRExDrag.use = false;
        buttonLExDrag.use = false;
        joystickExDrag.use = false;

      }
    }));

    joystick = new Joystick();
    joystick.addExtension(joystickExDrag= new ExDrag(joystick));
    joystickExDrag.use = false;
    addChild(buttonL);
    addChild(buttonR);
    addChild(joystick);
    addChild(buttonStop);
    resetController(stage);
  }

  void onChangeStageStatus(Stage stage, DisplayObject parent) {
    print(">>>test>>> [d] " + stage.w.toString() + " " + stage.toString());
    resetController(stage);
  }

  void resetController(Stage stage){
    if (joystick != null) {
      joystick.x = 170.0;
      joystick.y = stage.h - 75.0;
      joystick.scaleX = 2.35;
      joystick.scaleY = 2.35;
    }
    if (buttonL != null) {
      buttonL.x = stage.w - 130.0;
      buttonL.y = stage.h - 80.0;
      buttonL.scaleX = 0.25;
      buttonL.scaleY = 0.25;
    }
    if (buttonR != null) {
      buttonR.x = stage.w - 60.0;
      buttonR.y = stage.h - 120.0;
      buttonR.scaleX = 0.25;
      buttonR.scaleY = 0.25;
    }
    if (buttonStop != null) {
      buttonStop.x = stage.w / 2; //-buttonStop.w/2;
      buttonStop.y = stage.h - 50.0;
      buttonStop.scaleX = 0.2;
      buttonStop.scaleY = 0.2;
    }
  }

  void onPaint(Stage stage, Canvas canvas) {
    if(_isStop) {
      Paint paint = new Paint(color: new Color(0x77000000));
      canvas.drawRect(new Rect(0.0, 0.0, stage.w, stage.h), paint);
    }
  }
}
