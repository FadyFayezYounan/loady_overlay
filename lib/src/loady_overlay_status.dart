/// Enum representing the status of the Loady overlay.
///
/// The `LoadyOverlayStatus` enum has two possible values:
/// - `loading`: Indicates that the overlay is currently in a loading state.
/// - `idle`: Indicates that the overlay is currently idle.
///
/// This enum also provides two getter methods:
/// - `isLoading`: Returns `true` if the status is `loading`, otherwise `false`.
/// - `isIdle`: Returns `true` if the status is `idle`, otherwise `false`.
enum LoadyOverlayStatus {
  loading,
  idle;

  bool get isLoading => this == LoadyOverlayStatus.loading;
  bool get isIdle => this == LoadyOverlayStatus.idle;
}
