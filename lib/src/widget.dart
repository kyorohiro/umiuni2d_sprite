part of umiuni2d_sprite;

typedef Future OnStart(GameWidget widget);
typedef Future OnLoop(GameWidget widget);
abstract class GameWidget {
  Stage _stage;
  Stage get stage => _stage;

  Future<GameWidget> start({OnStart onStart, OnLoop onLoop, bool useAnimationLoop:false});
  Future<GameWidget> stop();

  Stage createStage({DisplayObject root});
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
}
