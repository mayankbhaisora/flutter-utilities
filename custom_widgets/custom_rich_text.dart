import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// [CustomRichText] is a Flutter widget that takes a text string
/// and an array of special words. It renders the text with special styling
/// applied to the parts of the text that match the special words.
///
/// Example usage:
/// ```dart
/// CustomRichText(
///   text: 'Hello Flutter!',
///   specialWords: ['Hello'],
///   specialStyle: TextStyle(
///     color: Colors.blue,
///     fontWeight: FontWeight.bold,
///   ),
/// )
///
class CustomRichText extends StatelessWidget {
  final void Function(int)? onTapSpecialWord;

  /// Main text shown by the widget.
  final String text;

  /// These strings are searched in given [text] and [specialStyle] is applied.
  final List<String> specialWords;
  final TextStyle? defaultStyle;
  final TextStyle? specialStyle;
  final TextAlign textAlign;

  const CustomRichText({
    super.key,
    required this.text,
    required this.specialWords,
    this.defaultStyle,
    this.specialStyle,
    this.textAlign = TextAlign.start,
    this.onTapSpecialWord,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? finalDefaultStyle =
        Theme.of(context).textTheme.bodyLarge?.merge(defaultStyle);
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: finalDefaultStyle,
        children: _buildTextSpanChildren(
          text: text,
          specialWords: specialWords,
          specialStyle: finalDefaultStyle
              ?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFB93072),
              )
              .merge(specialStyle),
        ),
      ),
    );
  }

  List<InlineSpan> _buildTextSpanChildren({
    required String text,
    required List<String> specialWords,
    required TextStyle? specialStyle,
  }) {
    List<InlineSpan> children = [];

    RegExp regExp = RegExp(specialWords.join('|'), caseSensitive: false);
    List<String> splits = text.split(regExp);
    List<RegExpMatch> matches = regExp.allMatches(text).toList();

    for (int i = 0; i < splits.length; i++) {
      String split = splits[i];
      children.add(
        TextSpan(
          text: split,
        ),
      );

      if (i < splits.length - 1) {
        final matchedWord = matches[i].group(0);
        children.add(
          TextSpan(
            text: matchedWord,
            style: specialStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTapSpecialWord?.call(i);
              },
          ),
        );
      }
    }
    return children;
  }
}
