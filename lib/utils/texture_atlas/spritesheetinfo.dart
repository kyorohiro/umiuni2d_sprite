part of umiuni2d_sprite;

class SpriteSheetInfo extends SpriteSheet {
  String json;
  List<SpriteSheetInfoFrame> frames = [];
  Map<String,SpriteSheetData> mmaps = {};

  SpriteSheetInfoFrame frameFromFileName(String fileName) {
    for (SpriteSheetInfoFrame f in frames) {
      if (f.fileName == fileName) {
        return f;
      }
    }
    return null;
  }

  SpriteSheetInfo.fronmJson(this.json) {
    parserFrames(this.json);
  }

  parserFrames(String input) {
    conv.JsonDecoder d = new conv.JsonDecoder();
    Map root = d.convert(input);
    print(root["frames"].toString());
    for (var frame in (root["frames"] as List<dynamic>)) {
      SpriteSheetInfoFrame f = new SpriteSheetInfoFrame.fromMap(frame);
      frames.add(f);
      mmaps[f.name] = f;
    }
  }

  Iterable<String> get keys => mmaps.keys;

  int get length => mmaps.length;

  SpriteSheetData operator [](String key) => mmaps[key];

  bool containsKey(String key) {
    return mmaps.containsKey(key);
  }

  draw(double x, double y, SpriteSheetInfoFrame f) {
  }
}

class SpriteSheetInfoFrame extends SpriteSheetData {
  String fileName;
  bool rotated;
  bool trimmed;
  Rect spriteSourceSize;
  Size sourceSize;
  Point pivot;
  Rect frame;
  String get name => fileName;
  Rect get dstRect {
    if (rotated) {
      double x = -1.0 * spriteSourceSize.y - (spriteSourceSize.h);
      double y = 1.0 * spriteSourceSize.x;
      double w = spriteSourceSize.h;
      double h = spriteSourceSize.w;
      return new Rect(x, y, w, h);
    } else {
      return new Rect(spriteSourceSize.x, spriteSourceSize.y, spriteSourceSize.w, spriteSourceSize.h);
    }
  }

  Rect get srcRect {
    if (rotated) {
      return new Rect(frame.x, frame.y, frame.h, frame.w);
    } else {
      return new Rect(frame.x, frame.y, frame.w, frame.h);
    }
  }

  double get angle {
    if (rotated) {
      return -1 + math.PI / 2.0;
    } else {
      return 0.0;
    }
  }

  SpriteSheetInfoFrame(this.fileName, this.frame, this.rotated, this.trimmed, this.spriteSourceSize, this.sourceSize, this.pivot) {}

  SpriteSheetInfoFrame.fromMap(Map frame) {
    this.fileName = frame["filename"];
    this.frame = parseRect(frame["frame"]);
    this.rotated = frame["rotated"];
    this.trimmed = frame["trimmed"];
    this.spriteSourceSize = parseRect(frame["spriteSourceSize"]);
    this.sourceSize = parseSize(frame["sourceSize"]);
    this.pivot = parsePoint(frame["pivot"]);
  }

  Rect parseRect(Map rect) {
    num x = rect["x"];
    num y = rect["y"];
    num w = rect["w"];
    num h = rect["h"];
    return new Rect(x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble());
  }

  Point parsePoint(Map point) {
    num x = point["x"];
    num y = point["y"];
    return new Point(x.toDouble(), y.toDouble());
  }

  Size parseSize(Map size) {
    num w = size["w"];
    num h = size["h"];
    return new Size(w.toDouble(), h.toDouble());
  }
}
