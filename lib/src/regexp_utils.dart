class RegExpUtils {
  static final RegExp textBetweenBrackets = RegExp(r'\[(.*?)\]');
  static final RegExp textBetweenParentheses = RegExp(r'\((.*?)\)');
  static final RegExp markDownLink = RegExp(r'\[(.*?)\]\((.*?)\)');
  static final RegExp brackets = RegExp(r'\[|\]');
  static final RegExp parentheses = RegExp(r'\(|\)');

  static String getFirst(String input, RegExp regExp) {
    final x = regExp.allMatches(input);
    if (x.isNotEmpty) {
      return x.first.group(0) ?? '';
    }
    return '';
  }

  static bool contains(String? input, RegExp regExp) {
    if (input == null) return false;
    return getFirst(input, regExp).isNotEmpty;
  }
}
