part of umiuni2d_sprite;

abstract class SpriteSheet {
  Iterable<Object> get keys;
  int get length;
  SpriteSheetData operator [](String key);
  bool containsKey(String key);
  SpriteSheet() {}
  factory SpriteSheet.spritsheet(String json) {
    return new SpriteSheetInfo.fronmJson(json);
  }

  factory SpriteSheet.bitmapfont(String json, int w, int h) {
    return new BitmapFont(json, w, h);
  }

  void drawImage(Canvas canvas, Image image, String name) {
    if (this[name] != null) {
      canvas.drawImageRect(image, this[name].srcRect, this[name].dstRect);
    }
  }

  Point drawText(Canvas canvas, Image image, String text, double size,
      {Rect rect: null,
        BitmapFontInfoType orientation: BitmapFontInfoType.horizontal,
        double margine: 5.0,
        Paint paint}) {
    if(orientation == BitmapFontInfoType.horizontal) {
      return drawTextHorizontal(canvas, image, text, size, rect: rect, margine: margine,paint: paint);
    } else {
      return drawTextVertical(canvas, image, text, size, rect: rect, margine: margine, paint:paint);
    }
  }

  Point drawTextHorizontal(Canvas canvas, Image image, String text, double size, {Rect rect: null, double margine: 5.0,Paint paint}) {
    if(rect == null) {
      rect = new Rect(0.0,0.0,10000.0,10000.0);
    }
    double x = rect.x;
    double y = rect.y;
    for (int i = 0; i < text.length; i++) {
      SpriteSheetData d = this[text[i]];
      if (d == null) {
        continue;
      }
      Rect dstRect = d.dstRect;
      dstRect.x = x;
      dstRect.y = y;
      dstRect.w = size * d.srcRect.w / d.srcRect.h;
      dstRect.h = size;
      if (rect != null) {
        if((rect.x+rect.w) < (dstRect.x + dstRect.w)){
          x = rect.x;
          y += dstRect.h + margine;
          dstRect.x = x;
          dstRect.y = y;
        }
      }
      canvas.drawImageRect(image, d.srcRect, dstRect, paint: paint);
      x += dstRect.w + margine * d.srcRect.w / d.srcRect.h;
    }
    return new Point(x, y+size + margine);
  }

  //
  Point drawTextVertical(Canvas canvas, Image image, String text, double size,
      {Rect rect: null, double margine: 5.0, Paint paint}) {
    if(rect == null) {
      rect = new Rect(0.0,0.0,10000.0,10000.0);
    }
    double x = 0.0;
    double y = 0.0;

    x = rect.x+rect.w;
    y = rect.y;
    double s = 0.0;
    for (int i = 0; i < text.length; i++) {
      SpriteSheetData d = this[text[i]];
      if (d == null) {
        continue;
      }
      Rect dstRect = d.dstRect;
      if(s <(size * d.srcRect.w / d.srcRect.h)) {
        s = size * d.srcRect.w / d.srcRect.h;
      }
      dstRect.w = size * d.srcRect.w / d.srcRect.h;
      dstRect.h = size;
      dstRect.x = x-dstRect.w;
      dstRect.y = y;

      if (rect != null) {
        if((rect.y+rect.h) < (dstRect.y + dstRect.h)){
          y = rect.y;
          x -= s;
          s = 0.0;
          dstRect.x = x-dstRect.w;
          dstRect.y = y;
        }
      }
      canvas.drawImageRect(image, d.srcRect, dstRect, paint: paint);
      y += dstRect.h + margine;
    }
    return new Point(x, y);
  }
}

abstract class SpriteSheetData {
  String name;
  Rect get dstRect;
  Rect get srcRect;
  double get angle;
}

class BitmapFont extends SpriteSheet {
  Map<Object, BitmapFontData> d = {};
  int imageWidth;
  int imageHeight;
  BitmapFont(String json, this.imageWidth, this.imageHeight) {
    BitmapFontInfo info = new BitmapFontInfo.fromJson(json);
    for (int key in info.r.keys) {
      String name = new String.fromCharCode(key);
      BitmapFontData v = new BitmapFontData(name, info.r[key], imageWidth.toDouble(), imageHeight.toDouble());
      d[key] = v;
      d[name] = v;
    }
  }
  Iterable<Object> get keys => d.keys;
  int get length => d.length;
  SpriteSheetData operator [](String key) => d[key];
  bool containsKey(String key) => d.containsKey(key);
}

class BitmapFontData extends SpriteSheetData {
  BitmapFontData(this.name, this.elm, this.imageWidth, this.imageHeight) {}
  String name;
  BitmapFontInfoElem elm;
  double imageWidth;
  double imageHeight;
  Rect get dstRect => elm.dstRect(imageWidth, imageHeight);
  Rect get srcRect => elm.srcRect(imageWidth, imageHeight);
  double get angle => 0.0;
}