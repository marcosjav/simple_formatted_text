part of 'widget.dart';

enum SimpleFormattedTextCommands {
  /// Start/End bold text.
  ///
  /// If you want to show the `*` character, write this at least two times.
  ///
  /// i.e.: " ** Lorem ipsum" will show " * Lorem ipsum" without bold text
  /// ## `*`
  ///
  boldChar,

  /// Start/End underlined text.
  ///
  /// If you want to show the `_` character, write this at least two times.
  ///
  /// i.e.: "Lorem__ipsum" will show "Lorem_ipsum" without underlined text
  ///
  /// ## `_`
  ///
  underlineChar,

  /// Start/End italic text.
  ///
  /// If you want to show the `/` character, write this at least two times.
  ///
  /// i.e.: "Lorem//ipsum" will show "Lorem/ipsum" without italic text
  ///
  /// ## `/`
  ///
  italicChar,

  /// Start/End strikethrough text.
  ///
  /// If you want to show the `~` character, write this at least two times.
  ///
  /// i.e.: "Lorem~~ipsum" will show "Lorem~ipsum" without strikethrough text
  ///
  /// ## `~`
  ///
  lineThroughChar,

  /// Start the link text.
  ///
  /// If you want to show the `[` character, write this at least two times.
  ///
  /// i.e.: "[[Lorem ipsum]]" will show "[Lorem ipsum]" without underlined text
  ///
  /// ## `[`
  ///
  startLinkTextChar,

  /// Start the link text.
  ///
  /// If you want to show the `]` character, write this at least two times.
  ///
  /// i.e.: "[[Lorem ipsum]]" will show "[Lorem ipsum]" without underlined text
  ///
  /// ## `]`
  ///
  endLinkTextChar,

  /// Start the link text.
  ///
  /// If you want to show the `(` character, write this at least two times.
  ///
  /// i.e.: "((Lorem ipsum))" will show "(Lorem ipsum)" without underlined text
  ///
  /// ## `(`
  ///
  startLinkUrlChar,

  /// Start the link text.
  ///
  /// If you want to show the `)` character, write this at least two times.
  ///
  /// i.e.: "((Lorem ipsum))" will show "(Lorem ipsum)" without underlined text
  ///
  /// ## `)`
  ///
  endLinkUrlChar,

  /// used to separate commands in parentheses
  ///
  /// i.e.:
  ///
  /// `[Big red text](addSize:4, color:#FFFF0000)`
  ///
  /// ## `subSize:`
  ///
  strSplitter,

  /// Sets the text color.
  ///
  /// Color must be hex number. You can parse a MaterialColor to Hex value using
  ///
  /// ```dart
  /// SimpleFormattedText.colorToHexStr(Color color)
  /// ```
  ///
  /// i.e.:
  ///
  /// `color:#FF0000FF`
  ///
  /// or:
  ///
  /// `"color: ${SimpleFormattedText.colorToHexStr(Colors.blue)}"`
  ///
  /// ## `color:`
  ///
  colorStr,

  /// Add size to text.
  ///
  /// Size must be `int` or `double`, and will be added to the actual size
  ///
  /// ## `addSize:`
  ///
  addSizeStr,

  /// Substract size to text.
  ///
  /// Size must be `int` or `double`, and will be substracted to the actual size
  ///
  /// ## `subSize:`
  ///
  subSizeStr;

  @override
  String toString() => _values[index]!;

  static const Map<int, String> _values = {..._chars, ..._strings};

  static const Map<int, String> _chars = {
    0: '*',
    1: '_',
    2: '/',
    3: '~',
    4: '[',
    5: ']',
    6: '(',
    7: ')',
    8: ',',
  };
  static const Map<int, String> _strings = {
    9: 'color:',
    10: 'addSize:',
    11: 'subSize:',
  };
}
