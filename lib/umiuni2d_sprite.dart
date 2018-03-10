library umiuni2d_sprite;

import 'dart:async';
import 'package:vector_math/vector_math_64.dart';
//import 'util.dart';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:convert' as conv;
//
part 'src/canvas.dart';
part 'src/color.dart';
part 'src/displayobject.dart';
part 'src/image.dart';
part 'src/paint.dart';
part 'src/point.dart';
part 'src/rect.dart';
part 'src/size.dart';
part 'package:umiuni2d_sprite/utils/sprites/sprite.dart';
part 'src/stage.dart';
part 'src/stage_base.dart';
part 'src/widget.dart';
part 'src/drawingshell.dart';

part 'src/gameroot.dart';
part 'src/gamebackground.dart';
part 'package:umiuni2d_sprite/utils/sprites/scene.dart';
//
//
//


//part 'tinygame_ex/controller/button.dart';
//part 'tinygame_ex/controller/joystick.dart';
part 'utils/texture_atlas/spritesheet.dart';
part 'utils/texture_atlas/spritesheetinfo.dart';
part 'utils/texture_atlas/bitmapfont.dart';
part 'utils/sprites/bitmaptext.dart';
part 'utils/sprites/displayobject_ex.dart';
part 'utils/sprites/exbutton.dart';
part 'utils/sprites/exblink.dart';

part 'utils/sprites/joystick.dart';



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