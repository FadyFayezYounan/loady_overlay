import 'package:flutter/material.dart';

import 'loady_controller.dart';
import 'loady_overlay_config.dart';
import 'loady_overlay_route.dart';
import 'loady_overlay_status.dart';

/// A widget that displays a centered adaptive circular progress indicator.
///
/// This widget is typically used as a default loading overlay to indicate
/// that a background task is in progress.
///
/// See also:
///
///  * [CircularProgressIndicator.adaptive], which adapts the progress indicator
///    to the current platform's design language.
class DefaultLoadyOverlayWidget extends StatelessWidget {
  const DefaultLoadyOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

abstract final class LoadyOverlay {
  /// The `LoadyOverlay` class provides static methods to show and hide a loading overlay.
  const LoadyOverlay._();

  static final _controller = LoadyController();

  /// Registers a callback to be invoked when the status changes.
  ///
  /// The provided [callback] will be called whenever the status changes,
  /// allowing you to handle status updates accordingly.
  ///
  /// Example usage:
  /// ```dart
  /// LoadyOverlay.onStatusChanged((status) {
  ///   // Handle status change
  /// });
  /// ```
  ///
  /// - [callback]: A function that takes a [LoadyStatus] as an argument.
  static void onStatusChanged(LoadyStatusCallback callback) {
    _controller.setStatusCallback(callback);
  }

  /// Displays a loading overlay on top of the current screen.
  ///
  /// This method shows a loading overlay using a custom [LoadyOverlayRoute].
  /// The overlay will be displayed until the route is popped, at which point
  /// the loading status will be reset to idle.
  ///
  /// The [context] parameter is required and should be the current build context.
  /// The optional [config] parameter allows customization of the overlay's appearance
  /// and behavior. If no configuration is provided, a default configuration will be used.
  ///
  /// If the loading overlay is already being displayed, this method will return immediately.
  ///
  /// - Parameters:
  ///   - context: The current build context.
  ///   - config: An optional configuration for the loading overlay.
  ///
  /// - Returns: A [Future] that completes when the overlay is dismissed.
  static void show(
    BuildContext context, {
    LoadyOverlayConfig? config,
  }) async {
    if (_controller.status.isLoading) return;

    final effectiveConfig = config ?? const LoadyOverlayConfig();

    _controller.changeStatus(LoadyOverlayStatus.loading);

    Navigator.of(context)
        .push(
          LoadyOverlayRoute(
            backgroundColor: effectiveConfig.backgroundColor,
            builder: effectiveConfig.builder ??
                (context) => const DefaultLoadyOverlayWidget(),
          ),
        )
        .whenComplete(() => _controller.changeStatus(LoadyOverlayStatus.idle));
  }

  /// Hides the loading overlay if it is currently being displayed.
  ///
  /// This method checks the status of the loading controller, and if it is
  /// in the loading state, it will pop the current route off the navigator
  /// stack, effectively hiding the overlay.
  ///
  /// [context] The BuildContext to use for navigating.
  static void hide(BuildContext context) {
    if (_controller.status.isLoading &&
        Navigator.of(context).canPop() &&
        ModalRoute.of(context) is LoadyOverlayRoute) {
      Navigator.of(context).pop();
    }
  }
}

/// Displays a loading overlay on top of the current screen.
void showLoadyOverlay(
  BuildContext context, {
  LoadyOverlayConfig? config,
}) async {
  LoadyOverlay.show(context, config: config);
}

/// Hides the loading overlay if it is currently being displayed.
void hideLoadyOverlay(BuildContext context) {
  LoadyOverlay.hide(context);
}
