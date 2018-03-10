part of umiuni2d_sprite;


class Color {
  static final Color black = new Color.argb(0xff, 0x00, 0x00, 0x00);
  static final Color white = new Color.argb(0xff, 0xff, 0xff, 0xff);

  static int mulInt(int x, int y) {
    double xa = ((x >> 24) & 0xff) / 255.0;
    double xr = ((x >> 16) & 0xff) / 255.0;
    double xg = ((x >> 8) & 0xff) / 255.0;
    double xb = ((x >> 0) & 0xff) / 255.0;
    double ya = ((y >> 24) & 0xff) / 255.0;
    double yr = ((y >> 16) & 0xff) / 255.0;
    double yg = ((y >> 8) & 0xff) / 255.0;
    double yb = ((y >> 0) & 0xff) / 255.0;
    int ret = 0;
    ret |= ((xa*ya) * 0xff).toInt() << 24;
    ret |= ((xr*yr) * 0xff).toInt() << 16;
    ret |= ((xg*yg) * 0xff).toInt() << 8;
    ret |= ((xb*yb) * 0xff).toInt() << 0;
  }

  int value = 0;
  Color(this.value) {}
  int get a => (value >> 24) & 0xff;
  int get r => (value >> 16) & 0xff;
  int get g => (value >> 8) & 0xff;
  int get b => (value >> 0) & 0xff;
  double get af => a / 255.0;
  double get rf => r / 255.0;
  double get gf => g / 255.0;
  double get bf => b / 255.0;

  Color.argb(int a, int r, int g, int b) {
    value |= (a & 0xff) << 24;
    value |= (r & 0xff) << 16;
    value |= (g & 0xff) << 8;
    value |= (b & 0xff) << 0;
    value &= 0xFFFFFFFF;
  }

  Color.mul(Color x, Color y) {
    int ret = 0;
    ret |= ((x.af*y.af) * 0xff).toInt() << 24;
    ret |= ((x.rf*y.rf) * 0xff).toInt() << 16;
    ret |= ((x.gf*y.gf) * 0xff).toInt() << 8;
    ret |= ((x.bf*y.bf) * 0xff).toInt() << 0;
    this.value = ret;
  }


  @override
  bool operator ==(o) => o is Color && o.value == value;

  @override
  int get hashCode => JenkinsHash.calc([value.hashCode]);

  @override
  String toString() {
    return "a:${a}, r:${r}, g:${g}, b:${b}";
  }

  String toRGBAString() {
    return "rgba(${r},${g},${b},${af})";
  }
}
