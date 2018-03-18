part of umiuni2d_sprite;

typedef Future OnStart(GameWidget widget);
typedef Future OnLoop(GameWidget widget);
abstract class GameWidget {
  Stage get stage;
  Map<String, Object> get objects;

  Future<GameWidget> start({OnStart onStart, OnLoop onLoop, bool useAnimationLoop:false});
  Future<GameWidget> stop();

  Stage createStage({DisplayObject root,DisplayObject background,DisplayObject front});
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
  //
  // size 2048 x 2048
  // num of 4.
  Future<ImageShader> createImageShader(Image image);
}

class ImageShader {
  int get w => 0;
  int get h => 0;
  void dispose(){;}
}