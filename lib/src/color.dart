part of umiuni2d_sprite;


class Color {
  static final Color black = new Color.argb(0xff, 0x00, 0x00, 0x00);
  static final Color white = new Color.argb(0xff, 0xff, 0xff, 0xff);

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
