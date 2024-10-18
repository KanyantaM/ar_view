# AR View

AR View is a Flutter package that enables developers to easily integrate augmented reality features into their applications using camera functionality. This package simplifies the process of displaying augmented images in a real-world view.

## Features

- **Camera Integration**: Seamlessly integrate camera functionalities to capture real-time video.
- **Augmented Reality**: Add and manipulate images in an augmented reality context.
- **Image Handling**: Supports adding, moving, and resizing images within the AR view.
- **Easy Setup**: Simple API for quick implementation in your Flutter applications.

## Getting Started

To get started with the `ar_view` package, follow these steps:

1. **Prerequisites**:
   - Flutter SDK installed (version 1.17.0 or higher).
   - Camera permissions set up in your `AndroidManifest.xml` and `Info.plist` files.
   - Basic understanding of Flutter and Dart.

2. **Add Dependency**:
   Add the following line to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     ar_view: ^0.0.3
   ```

3. **Install Packages**:
   Run the following command to install the package:

   ```bash
   flutter pub get
   ```

## Usage

Here's a quick example of how to use the `ar_view` package in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ar_view/ar_view.dart';


List<CameraDescription> allCameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    allCameras = await availableCameras();
  } on CameraException catch (errorMessage) {
    // Provide more context in error handling
    debugPrint('Camera error: ${errorMessage.description}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AugmentedRealityView(),
    );
  }
}
```

For more detailed examples, check the `/example` folder included in this package.

## Additional Information

For more information about the `ar_view` package:

- **Documentation**: [API Documentation](https://pub.dev/documentation/ar_view/latest/)
- **Contributing**: Contributions are welcome! Please read the [CONTRIBUTING.md](https://github.com/KanyantaM/ar_view/blob/main/CONTRIBUTING.md) for guidelines.
- **Issues**: If you encounter any problems or have questions, please file an issue on the [GitHub Issues page](https://github.com/KanyantaM/ar_view/issues).
- **Support**: Expect a response from the package authors within a few days.
