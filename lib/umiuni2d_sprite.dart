library umiuni2d_sprite;

import 'dart:async';
import 'package:vector_math/vector_math_64.dart';
//import 'util.dart';
import 'dart:typed_data';
import 'dart:math' as math;
//
part 'src/canvas.dart';
part 'src/color.dart';
part 'src/displayobject.dart';
part 'src/image.dart';
part 'src/paint.dart';
part 'src/point.dart';
part 'src/rect.dart';
part 'src/size.dart';
part 'src/sprite.dart';
part 'src/stage.dart';
part 'src/stage_base.dart';
part 'src/widget.dart';
part 'src/drawingshell.dart';

part 'src/gameroot.dart';
part 'src/gamebackground.dart';

abstract class Platform {
  Future<double> getDisplayDensity();
  Future<String> loadString(String path);
  Future<Image> loadImage(String path);
  Future<Uint8List> loadBytes(String path);
  Future<String> getLocale();
}

class JenkinsHash {
  static int calc(List<int> vs) {
    int v1 = 0;
    for (int v2 in vs) {
      v1 += v2;
      v1 += v1 << 10;
      v1 ^= (v1 >> 6);
    }
    v1 += v1 << 3;
    v1 ^= v1 >> 11;
    v1 += v1 << 15;

    return v1;
  }
}