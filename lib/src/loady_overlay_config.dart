import 'package:flutter/material.dart';

/// Configuration class for LoadyOverlay.
///
/// This class holds the configuration options for the LoadyOverlay widget,
/// including the background color and a custom builder for the loading indicator.
final class LoadyOverlayConfig {
  /// Creates a [LoadyOverlayConfig] instance.
  ///
  /// The [backgroundColor] parameter specifies the background color of the overlay.
  /// The [builder] parameter allows for a custom widget builder for the loading indicator.
  const LoadyOverlayConfig({
    this.backgroundColor = Colors.black26,
    this.builder,
  });

  /// The background color of the overlay.
  final Color backgroundColor;

  /// A custom widget builder for the loading indicator.
  final WidgetBuilder? builder;

  @override
  bool operator ==(covariant LoadyOverlayConfig other) {
    if (identical(this, other)) return true;

    return other.backgroundColor == backgroundColor && other.builder == builder;
  }

  @override
  int get hashCode => backgroundColor.hashCode ^ builder.hashCode;

  @override
  String toString() =>
      'LoadyOverlayConfig(backgroundColor: $backgroundColor, loadingIndicator: $builder)';
}
