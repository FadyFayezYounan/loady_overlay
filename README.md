# Loady Overlay

A simple and customizable loading overlay package for Flutter applications.

## 🚀 Features

- Easy-to-use loading overlay management
- Customizable loading indicator
- Status callback support
- Lightweight and efficient

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  loady_overlay: ^0.0.3
```

Then run:

```bash
flutter pub get
```

## 🛠️ Basic Usage

### Showing a Loading Overlay

```dart
// Simple usage
await showLoadyOverlay(context);
// Or use case use
 LoadyOverlay.show(context);

// With custom configuration
await showLoadyOverlay(
  context,
  config: LoadyOverlayConfig(
    backgroundColor: Colors.black54,
    builder: (context) => CustomLoadingIndicator(),
  ),
);

// Or use case use
LoadyOverlay.show(
  context,
  config: LoadyOverlayConfig(
    backgroundColor: Colors.black54,
    builder: (context) => CustomLoadingIndicator(),
  ),
);
```

### Hiding a Loading Overlay

```dart
hideLoadyOverlay(context);

// Or use case use
LoadyOverlay.hide(context);
```

### Listening to Status Changes

```dart
LoadyOverlay.onStatusChanged((status) {
  print('Loading status: $status');
});
```

## 📝 API Reference

### `showLoadyOverlay`

Shows a loading overlay on top of the current screen.

**Parameters:**

- `context`: BuildContext (required)
- `config`: Optional configuration for the overlay

### `hideLoadyOverlay`

Hides the currently displayed loading overlay.

**Parameters:**

- `context`: BuildContext (required)

### `LoadyOverlayConfig`

Allows customization of the loading overlay:

- `backgroundColor`: Color of the overlay background
- `builder`: Custom widget builder for the loading indicator

## 🎨 Customization

You can create a custom loading indicator by implementing your own widget:

```dart
class CustomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyCustomProgressIndicator(),
    );
  }
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
