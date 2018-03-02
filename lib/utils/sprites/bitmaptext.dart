part of umiuni2d_sprite;


class BitmapTextSprite extends Sprite {

  Image _image;
  String _jsonSrc;
  SpriteSheet _sheet = null;
  Rect _rect;

  Image get image => _image;
  String get jsonSrc => _jsonSrc;
  SpriteSheet get sheet => _sheet;
  Rect rect;
  String message;
  double size;

  Color color;

  BitmapTextSprite(Image image, String jsonSrc,
      {this.rect, this.size:25.0, this.message="", this.color:null}) :super.empty() {
    this._image = image;
    this._jsonSrc = jsonSrc;
    this._sheet = new SpriteSheet.bitmapfont(jsonSrc, image.w, image.h);
  }

  void onPaint(Stage stage, Canvas canvas) {
    Paint p = null;
    if(color != null) {
      p = new Paint(color: color);
    }
    sheet.drawText(canvas, image, message, size,
        rect: _rect, orientation: BitmapFontInfoType.horizontal,paint: p);
  }
}