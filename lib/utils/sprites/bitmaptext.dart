part of umiuni2d_sprite;


class BitmapTextSprite extends Sprite {

  Image _image;
  String _jsonSrc;
  SpriteSheet _sheet = null;

  Image get image => _image;
  String get jsonSrc => _jsonSrc;
  SpriteSheet get sheet => _sheet;
  Rect rect;
  String message;
  double size;

  Color color;

  BitmapTextSprite(Image image, String jsonSrc,
      {this.rect, this.size:25.0, this.message="", this.color:null}) :
        super.empty(w:(rect==null?0.0:rect.w), h:(rect==null?0.0:rect.h),centerX:0.0,centerY:0.0) {
    this._image = image;
    this._jsonSrc = jsonSrc;
    this._sheet = new SpriteSheet.bitmapfont(jsonSrc, image.w, image.h);
//    this.focusMergine = 1.2;

  }

  void onPaint(Stage stage, Canvas canvas) {
    Paint p = null;
    if(color != null) {
      p = new Paint(color: color);
    }

    Point point = sheet.drawText(canvas, image, message, size,
        rect: rect,
        orientation: BitmapFontInfoType.horizontal,paint: p);
    if(rect == null) {
      this.spriteW = point.x;
      this.spriteH = point.y;
    }
    //print("${point}");
    //if(this.rect != null)
    //{
    //  Rect r= new Rect(0.0, 0.0, this.spriteW, this.spriteH);
    //  r.w = this.spriteW;
    //  r.h = this.spriteH;
    //  canvas.drawRect(r, new Paint(color: new Color(0x552222ff)));
    //}
  }
}