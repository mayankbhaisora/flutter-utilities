import 'package:flutter/cupertino.dart';

class CollapsedTextWidget extends StatefulWidget {
  const CollapsedTextWidget(
      {super.key,
      required this.text,
      this.maxLines = 2,
      this.mainTextStyle,
      this.actionTextStyle,
      this.showActionText = true,
      this.collapseActionText = 'Collapse',
      this.expandActionText = 'Expand'});

  final String text;
  final int maxLines;
  final TextStyle? mainTextStyle;
  final TextStyle? actionTextStyle;
  final bool showActionText;
  final String collapseActionText;
  final String expandActionText;

  @override
  State<CollapsedTextWidget> createState() => _CollapsedTextWidgetState();
}

class _CollapsedTextWidgetState extends State<CollapsedTextWidget> {
  bool _isExpanded = false;

  final TextStyle _defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: Color(0xFF6D4D7E),
    letterSpacing: 0.70,
  );

  @override
  void initState() {
    // Expand the widget by default if action text is disabled
    _isExpanded = !widget.showActionText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
            style: widget.mainTextStyle ?? _defaultTextStyle,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Visibility(
          visible: widget.showActionText,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded
                    ? widget.collapseActionText
                    : widget.expandActionText,
                style: widget.actionTextStyle ??
                    _defaultTextStyle.copyWith(color: const Color(0xFFB93072)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
