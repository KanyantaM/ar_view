import 'package:ar_view/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      home: AugmentedRealityView(allCameras: allCameras),
    );
  }
}
