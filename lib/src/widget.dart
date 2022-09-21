import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_formatted_text/src/regexp_utils.dart';

part 'enum.dart';

class SimpleFormattedText extends StatelessWidget {
  static const TextStyle _linkTextStyle = TextStyle(fontSize: 14, color: Color(0xFF1A73E8));

  final String text;
  final TextStyle? style;
  final TextStyle linkTextStyle;
  final TextAlign? textAlign;

  /// On url link tap function
  final void Function(String url)? onLinkTap;

  /// Shows a formatted [text] using special chars
  ///
  /// - Bold:           `*`
  /// - Italic:         `/`
  /// - Underlined:     `_`
  /// - Linethrough:    `~`
  /// - Link:     `[Link text Here](https://link-url-here.org)`
  /// - Big size:     `[Bigger text](addSize:2)`
  /// - Small size:    `[Smaller text](subSize:2)`
  /// - Color:    `[Colored text](color:#ffccffcc)`
  /// - Multiple: `[Colored big text](color:#ffccffcc, addSize:4)`
  ///
  /// If you need to show an special char, put it at least twice
  ///
  /// Example:
  ///
  /// ### `"**This *text* contains /many/ ~special~ chars"`
  ///
  /// Shows:
  ///
  ///  "*This **text** contains _many_ ~special~ chars"
  const SimpleFormattedText(this.text, {this.style, Key? key, this.textAlign, this.onLinkTap, TextStyle? linkTextStyle})
      : linkTextStyle = linkTextStyle ?? _linkTextStyle,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> sections = [];
    TextStyle lastStyle = style ?? DefaultTextStyle.of(context).style;
    int i = 0;
    String str = text;
    bool bold = false;
    bool italic = false;
    bool underline = false;
    bool lineThrough = false;

    for (int j = 0; j < str.length; j++) {
      final String c = str[j];
      bool isLink = false;
      if (SimpleFormattedTextCommands._chars.values.contains(c)) {
        // It's link
        if (c == SimpleFormattedTextCommands.startLinkTextChar.toString()) {
          int k = str.indexOf(SimpleFormattedTextCommands.endLinkUrlChar.toString(), j);
          if (k > -1) {
            final String s = str.substring(j, k + 1);
            isLink = _isLink(s);
            if (isLink) {
              final textToShow = RegExpUtils.getFirst(s, RegExpUtils.textBetweenBrackets).replaceAll(RegExpUtils.brackets, "");
              final urlLink = RegExpUtils.getFirst(s, RegExpUtils.textBetweenParentheses).replaceAll(RegExpUtils.parentheses, "");
              str = str.replaceFirst(s, "", j);

              // add last section styled
              final ss = str.substring(i, j);
              if (ss.isNotEmpty) sections.add(TextSpan(text: ss, style: lastStyle));

              i = j--;
              if (SimpleFormattedTextCommands._strings.values.any((e) => urlLink.contains(e))) {
                List<String> values = urlLink.split(SimpleFormattedTextCommands.strSplitter.toString());
                TextStyle style = lastStyle.copyWith();
                for (var value in values) {
                  value = value.trim();
                  if (value.startsWith(SimpleFormattedTextCommands.colorStr.toString())) {
                    final color = colorFromHexStr(value.replaceAll(SimpleFormattedTextCommands.colorStr.toString(), ""));
                    style = style.copyWith(color: color);
                  } else if (value.startsWith(SimpleFormattedTextCommands.addSizeStr.toString())) {
                    final size = (style.fontSize ?? 14) + (double.tryParse(value.replaceAll(SimpleFormattedTextCommands.addSizeStr.toString(), "").trim()) ?? 0);
                    style = style.copyWith(fontSize: size);
                  } else if (value.startsWith(SimpleFormattedTextCommands.subSizeStr.toString())) {
                    final size = (style.fontSize ?? 14) - (double.tryParse(value.replaceAll(SimpleFormattedTextCommands.subSizeStr.toString(), "").trim()) ?? 0);
                    style = style.copyWith(fontSize: size);
                  }
                }
                sections.add(
                  TextSpan(
                    text: textToShow,
                    style: style,
                  ),
                );
              } else {
                sections.add(
                  TextSpan(
                    text: textToShow,
                    style: linkTextStyle.copyWith(fontSize: lastStyle.fontSize),
                    mouseCursor: SystemMouseCursors.click,
                    recognizer: TapGestureRecognizer()..onTap = () => onLinkTap?.call(urlLink),
                  ),
                );
              }
            }
          }
        }
        // Isn't link
        if (!isLink) {
          if (j + 1 == str.length || str[j + 1] != str[j]) {
            // add last section styled
            final ss = str.substring(i, j);
            if (ss.isNotEmpty) {
              sections.add(TextSpan(text: ss, style: lastStyle));
            }

            // set new style
            bold = c == SimpleFormattedTextCommands.boldChar.toString() ? !bold : bold;
            italic = c == SimpleFormattedTextCommands.italicChar.toString() ? !italic : italic;
            underline = c == SimpleFormattedTextCommands.underlineChar.toString() ? !underline : underline;
            lineThrough = c == SimpleFormattedTextCommands.lineThroughChar.toString() ? !lineThrough : lineThrough;

            // set new start index and new style
            i = j + 1;
            TextDecoration decoration = TextDecoration.combine([
              underline ? TextDecoration.underline : TextDecoration.none,
              if (lineThrough) TextDecoration.lineThrough,
            ]);
            lastStyle = lastStyle.copyWith(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
              decoration: decoration,
            );
          } else {
            str = replaceCharAt(str, j, "");
          }
        }
      }
    }

    if (i < str.length) {
      sections.add(TextSpan(text: str.substring(i), style: lastStyle));
    }

    return RichText(
      text: TextSpan(text: "", children: sections),
      textAlign: textAlign ?? TextAlign.start,
    );
  }

  bool _isLink(String text) => RegExpUtils.getFirst(text, RegExpUtils.markDownLink).isNotEmpty;

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  static Color colorFromHexStr(String hexString) {
    final buffer = StringBuffer();
    hexString = hexString.trim();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceAll('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String colorToHexStr(Color color) => '#'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}
