part of umiuni2d_sprite;

typedef Future OnStart(GameWidget widget);
abstract class GameWidget {
  Stage _stage;
  Stage get stage => _stage;
  void start({OnStart onStart, bool useAnimationLoop:false});
  void stop();
  void run();

  Stage createStage({DisplayObject root});
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
}
