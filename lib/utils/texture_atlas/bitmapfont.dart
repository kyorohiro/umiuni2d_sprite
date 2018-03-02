//
// use http://sapphire-al2o3.github.io/font_tex/
//
part of umiuni2d_sprite;

enum BitmapFontInfoType { vertical, horizontal }

class BitmapFontInfo {
  Map<int, BitmapFontInfoElem> r = {};
  int errorCodeUnit = " ".codeUnitAt(0);

  BitmapFontInfoElem getFromCOdeUnit(int unit) {
    if (r.containsKey(unit)) {
      return r[unit];
    } else {
      return r[errorCodeUnit];
    }
  }

  BitmapFontInfo.fromJson(String input) {
    conv.JsonDecoder d = new conv.JsonDecoder();
    Map<String, Object> root = d.convert(input);
    for (String k in root.keys) {
      Map<String, num> e = root[k];
      r[int.parse(k)] = new BitmapFontInfoElem(e["u"].toDouble(), e["v"].toDouble(), e["w"].toDouble(), e["h"].toDouble(), e["vx"].toDouble(), e["vy"].toDouble(), e["vw"].toDouble(), e["vh"].toDouble());
    }
  }

  drawText(Stage stage, Canvas canvas, Image fontImg, String text, double height, Rect rect, {BitmapFontInfoType vertical: BitmapFontInfoType.horizontal}) {
    Rect src = new Rect(0.0, 0.0, 0.0, 0.0);
    Rect dst = new Rect(0.0, 0.0, 0.0, 0.0);

    double x = rect.x;
    double y = rect.y;
    double imgW = fontImg.w.toDouble();
    double imgH = fontImg.h.toDouble();
    for (int unit in text.codeUnits) {
      BitmapFontInfoElem elm = getFromCOdeUnit(unit);
      src.w = elm.srcRect(imgW, imgH).w;
      src.h = elm.srcRect(imgW, imgH).h;
      src.x = elm.srcRect(imgW, imgH).x;
      src.y = elm.srcRect(imgW, imgH).y;
      dst.x = x;
      dst.y = y;
      dst.w = src.w * height / src.h;
      dst.h = height;
      if ((dst.x + dst.w) > rect.w) {
        dst.x = rect.x;
        dst.y += height + 5;
      }
      canvas.drawImageRect(fontImg, src, dst);
      x = dst.x + dst.w + 2;
      y = dst.y;
    }
  }
}

class BitmapFontInfoElem {
  final double u;
  final double v;
  final double w;
  final double h;
  final double vx;
  final double vy;
  final double vw;
  final double vh;

  Size _dst = new Size(0.0, 0.0);
  Rect _dstR = new Rect(0.0, 0.0, 0.0, 0.0);
  Rect _srcR = new Rect(0.0, 0.0, 0.0, 0.0);

  Size dstSize(double width, double height) {
    _dst.w = w * width;
    _dst.h = h * height;
    return _dst;
  }

  Rect dstRect(double width, double height) {
    _dstR.x = 0.0;
    _dstR.y = 0.0;
    _dstR.w = w * width;
    _dstR.h = h * height;
    return _dstR;
  }

  Rect srcRect(double width, double height) {
    _srcR.x = width * u;
    _srcR.y = height - height * (v) - h * height;
    _srcR.w = w * width;
    _srcR.h = h * height;
    return _srcR;
  }

  double get angle => 0.0;

  BitmapFontInfoElem(this.u, this.v, this.w, this.h, this.vx, this.vy, this.vw, this.vh) {}
}