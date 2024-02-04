import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.gridDelegate,
    this.shrinkWrap = false,
    this.noItemsText,
    this.noItemsTextStyle,
    this.onReachedMaxScrollExtent,
  });

  /// Callback when grid view is scrolled to it's end.
  ///
  /// * [onReachedMaxScrollExtent] is called when grid view is scrolled to end.
  /// It can be used to load more data only when it is needed
  final VoidCallback? onReachedMaxScrollExtent;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final SliverGridDelegate? gridDelegate;
  final bool shrinkWrap;
  final ScrollController? controller;

  /// This text is shown when item count is 0.
  final String? noItemsText;

  /// TextStyle for noItemsText.
  final TextStyle? noItemsTextStyle;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  final ScrollController _scrollController = ScrollController();

  final TextStyle _defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: Color(0xFF6D4D7E),
    letterSpacing: 0.70,
  );

  final SliverGridDelegate _defaultGridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 20,
    crossAxisSpacing: 16,
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
          ? GridView.builder(
              itemCount: widget.itemCount,
              shrinkWrap: widget.shrinkWrap,
              controller: widget.controller ?? _scrollController,
              gridDelegate: widget.gridDelegate ?? _defaultGridDelegate,
              itemBuilder: widget.itemBuilder,
            )
          : (widget.noItemsText ?? '').isNotEmpty
              ? SizedBox(
                  height: 400,
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
