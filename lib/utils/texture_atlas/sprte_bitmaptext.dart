part of tinygame_ex;


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

  BitmapTextSprite(Image image, String jsonSrc, {this.rect, this.size:25.0, this.message=""}) :super.empty() {
    this._image = image;
    this._jsonSrc = jsonSrc;
    this._sheet = new SpriteSheet.bitmapfont(jsonSrc, image.w, image.h);
  }

  void onPaint(Stage stage, Canvas canvas) {
    sheet.drawText(canvas, image, message, size,
        rect: _rect, orientation: BitmapFontInfoType.horizontal);
  }
}