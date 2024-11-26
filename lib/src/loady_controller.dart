import 'loady_overlay_status.dart';

typedef LoadyStatusCallback = void Function(LoadyOverlayStatus status);

/// A controller class for managing the status of a Loady overlay.
///
/// This class follows the singleton pattern to ensure only one instance
/// of the controller is created.
///
/// The [LoadyController] provides methods to set a status callback and
/// change the status of the overlay. When the status is changed, the
/// registered callback is invoked with the new status.
final class LoadyController {
  /// Private constructor for internal use.
  LoadyController._internal();

  /// Singleton instance of the [LoadyController].
  static LoadyController? _instance;

  /// Factory constructor to return the singleton instance.
  factory LoadyController() {
    return _instance ??= LoadyController._internal();
  }

  LoadyOverlayStatus? _status;

  /// Gets the current status of the Loady overlay.
  ///
  /// Returns [LoadyOverlayStatus.idle] if the status is not set.
  LoadyOverlayStatus get status => _status ?? LoadyOverlayStatus.idle;

  LoadyStatusCallback? _statusCallback;

  /// Gets the current status callback.
  LoadyStatusCallback? get statusCallback => _statusCallback;

  /// Sets the status callback to be invoked when the status changes.
  ///
  /// The callback is called with the new status whenever [changeStatus] is called.
  void setStatusCallback(LoadyStatusCallback? callback) =>
      _statusCallback = callback;

  /// Changes the status of the Loady overlay and invokes the status callback.
  ///
  /// The [status] parameter is the new status to set.
  void changeStatus(LoadyOverlayStatus status) {
    _status = status;
    _statusCallback?.call(status);
  }
}
