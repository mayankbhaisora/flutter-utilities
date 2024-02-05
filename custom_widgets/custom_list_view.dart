import 'package:flutter/cupertino.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = true,
    this.noItemsText,
    this.noItemsTextStyle,
    this.onReachedMaxScrollExtent,
    this.itemExtent,
  });

  /// Callback when list view is scrolled to it's end.
  ///
  /// * [onReachedMaxScrollExtent] is called when list view is scrolled to end.
  /// It can be used to load more data only when it is needed
  final VoidCallback? onReachedMaxScrollExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double? itemExtent;
  final int itemCount;
  final ScrollController? controller;
  final Axis scrollDirection;
  final bool shrinkWrap;
  /// This text is shown when item count is 0.
  final String? noItemsText;
  /// TextStyle for noItemsText.
  final TextStyle? noItemsTextStyle;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final ScrollController _scrollController = ScrollController();

  final TextStyle _defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: Color(0xFF6D4D7E),
    letterSpacing: 0.70,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.onReachedMaxScrollExtent?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: widget.itemCount > 0
          ? ListView.builder(
              shrinkWrap: widget.shrinkWrap,
              scrollDirection: widget.scrollDirection,
              itemExtent: widget.itemExtent,
              itemCount: widget.itemCount,
              controller: widget.controller ?? _scrollController,
              itemBuilder: widget.itemBuilder,
            )
          : (widget.noItemsText ?? '').isNotEmpty
              ? SizedBox(
                  // height: 400,
                  child: Center(
                    child: Text(
                      widget.noItemsText ?? '',
                      style: widget.noItemsTextStyle ?? _defaultTextStyle,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
    );
  }
}
