import 'package:flutter/material.dart';

/// [IndexIndicators] is a Flutter widget that shows list of indicators/widgets
/// and also one active/highlighted widget.
/// User can tap any widget and the active/highlighted widget is shown at that index.
///
/// Example usage:
/// ```dart
/// IndexIndicators(
///   size: 15,
///   initialActiveIndex: 2,
///   onTap: (index) {
///     print("Selected Index: $index");
///   },
///   builder: (index, activeIndex) => Padding(
///     padding: const EdgeInsets.only(left: 5),
///     child: Container(
///       width: 40,
///       height: 40,
///       color: index == activeIndex ? Colors.red : Colors.green,
///     ),
///   ),
/// ),
///
class IndexIndicators extends StatefulWidget {
  /// A builder function that returns a widget based on the provided indices.
  ///
  /// The `builder` function takes two parameters:
  /// - `index`: The current index for which the widget is being built.
  /// - `activeIndex`: The active index in the widget's context, typically used
  ///   for highlighting or distinguishing the active item.
  ///
  /// The function should return a widget that corresponds to the given indices.
  /// - If `builder` is `null`, the default builder will be used.
  ///
  final Widget Function(int index, int activeIndex)? builder;
  /// [onTap] is called when specific index is tapped
  /// and tappedIndex is received as function parameter
  final void Function(int tappedIndex)? onTap;
  /// Total number of indexes/widgets to be shown
  final int size;
  /// Initially active index
  final int initialActiveIndex;
  final MainAxisAlignment mainAxisAlignment;

  const IndexIndicators({
    super.key,
    required this.size,
    required this.initialActiveIndex,
    this.onTap,
    this.builder,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  State<IndexIndicators> createState() => _IndexIndicatorsState();
}

class _IndexIndicatorsState extends State<IndexIndicators> {

  int _activeIndex = 0;

  @override
  void initState() {
    _activeIndex = widget.initialActiveIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> indexes = List.generate(widget.size, (index) => index);

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: indexes.map((index) {
        return GestureDetector(
          onTap: () {
            _onTap(index);
          },
          child: widget.builder != null
              ? widget.builder!(index, _activeIndex)
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: index == _activeIndex
                        ? const Color(0xFFB93072)
                        : const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
        );
      }).toList(),
    );
  }

  void _onTap(int index) {
    widget.onTap?.call(index);
    setState(() {
      _activeIndex = index;
    });
  }
}
