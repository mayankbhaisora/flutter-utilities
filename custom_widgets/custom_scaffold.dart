import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A custom scaffold widget that allows the display of an overlay child on top
/// of the main child and provides control over the visibility of the app bar and
/// navigation pop behavior.
///
/// This widget is designed to provide a simple way to show an additional view,
/// such as a loading indicator, over the main content. The overlay child is
/// displayed as an overlay if [showOverlayChild] is `true`.
///
/// The main child is the primary content of the screen, and the overlay child
/// is optional and can be used to show temporary or contextual content over the
/// main child.
///
/// The app bar can be customized using the [appBar] property. If [showAppBar]
/// is `true` and [appBar] is not specified, a default app bar will be displayed.
///
/// The navigation behavior can be controlled using the [onWillPop] and [onPopInvoked]
/// properties. The [onWillPop] property determines whether the screen can be popped,
/// and [onPopInvoked] is a callback invoked when a pop is done.
///
/// Example usage:
///
/// ```dart
/// CustomScaffoldWidget(
///   canPop: false,
///   child: YourMainContentWidget(),
///   overlayChild: YourOverlayWidget(),
///   showOverlayChild: false, // Set to true to show overlay
/// )
///
class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    required this.child,
    this.overlayChild,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.showAppBar = true,
    this.showOverlayChild = true,
    this.canPop = true,
    this.onPopInvoked,
  });

  /// The main child widget that forms the primary content of the screen.
  final Widget child;

  /// The overlay child widget that is displayed over the main child when
  /// [showOverlayChild] is `true`.
  final Widget? overlayChild;

  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  /// Controls the visibility of the app bar. If `true` and [appBar] is not
  /// specified, a default app bar will be displayed. If `false`, the app bar
  /// will be hidden.
  final bool showAppBar;

  /// Controls whether the overlay child should be displayed. If `true`, the
  /// overlay child is shown; otherwise, it is hidden.
  final bool showOverlayChild;

  /// When false, blocks the current route from being popped.
  ///
  /// This includes the root route, where upon popping, the Flutter app would
  /// exit.
  ///
  /// If multiple [PopScope] widgets appear in a route's widget subtree, then
  /// each and every `canPop` must be `true` in order for the route to be
  /// able to pop.
  ///
  /// [Android's predictive back](https://developer.android.com/guide/navigation/predictive-back-gesture)
  /// feature will not animate when this boolean is false.
  final bool canPop;

  /// Called after a route pop was handled.
  ///
  /// It's not possible to prevent the pop from happening at the time that this
  /// method is called; the pop has already happened. Use [canPop] to
  /// disable pops in advance.
  ///
  /// This will still be called even when the pop is canceled. A pop is canceled
  /// when the relevant [Route.popDisposition] returns false, such as when
  /// [canPop] is set to false on a [PopScope]. The `didPop` parameter
  /// indicates whether or not the back navigation actually happened
  /// successfully.
  ///
  /// See also:
  ///
  ///  * [Route.onPopInvoked], which is similar.
  final PopInvokedCallback? onPopInvoked;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late PreferredSizeWidget _defaultAppBar;

  @override
  void initState() {
    super.initState();
    _initializeAppBar();
  }

  void _initializeAppBar() {
    _defaultAppBar = PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      onPopInvoked: widget.onPopInvoked,
      child: Scaffold(
        body: Stack(
          children: [
            widget.child,
            if (widget.showOverlayChild && widget.overlayChild != null)
              widget.overlayChild!
          ],
        ),
        appBar: widget.showAppBar ? widget.appBar ?? _defaultAppBar : null,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        persistentFooterAlignment: widget.persistentFooterAlignment,
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged,
        endDrawer: widget.endDrawer,
        onEndDrawerChanged: widget.onEndDrawerChanged,
        drawerScrimColor: widget.drawerScrimColor,
        backgroundColor: widget.backgroundColor,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
        restorationId: widget.restorationId,
      ),
    );
  }
}
