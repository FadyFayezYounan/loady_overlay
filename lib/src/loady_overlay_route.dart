import 'package:flutter/material.dart';

class LoadyOverlayRoute extends ModalRoute<void> {
  /// A custom modal route that displays an overlay with a specified background color
  /// and a builder for the content.
  ///
  /// The `LoadyOverlayRoute` class extends `ModalRoute<void>` and provides
  /// customization options for the overlay's appearance and behavior.
  ///
  /// The overlay is non-opaque, non-dismissible, and does not maintain its state
  /// when dismissed. The transition duration for the overlay is set to 200 milliseconds.
  ///
  /// The `PopScope` widget is used to prevent the back button from dismissing the overlay.
  ///
  /// Parameters:
  /// - `builder`: A `WidgetBuilder` that builds the content of the overlay.
  /// - `backgroundColor`: A `Color` that sets the background color of the overlay.
  ///
  /// Example usage:
  /// ```dart
  /// Navigator.of(context).push(LoadyOverlayRoute(
  ///   builder: (context) => YourWidget(),
  ///   backgroundColor: Colors.black54,
  /// ));
  /// ```
  LoadyOverlayRoute({
    required this.builder,
    required this.backgroundColor,
    super.settings,
    super.filter,
  });

  final WidgetBuilder builder;
  final Color backgroundColor;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => backgroundColor;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // PopScope prevents back button dismissal
    return PopScope(
      canPop: false,
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: builder(context),
        ),
      ),
    );
  }

  @override
  String toString() =>
      'LoadyOverlayRoute(builder: $builder, backgroundColor: $backgroundColor)';
}
