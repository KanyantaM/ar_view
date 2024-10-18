import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AugmentedRealityView extends StatefulWidget {
  final List<CameraDescription>? allCameras;
  const AugmentedRealityView({super.key, this.allCameras});

  @override
  State<AugmentedRealityView> createState() => _AugmentedRealityViewState();
}

class _AugmentedRealityViewState extends State<AugmentedRealityView> {
  CameraController? cameraController;
  Future<void>? _initializeControllerFuture;
  List<Map<String, dynamic>> images = [];
  String? selectedImageUrl;
  List<CameraDescription> allCameras = [];

  @override
  void initState() {
    super.initState();
    allCameras = widget.allCameras ?? [];
    _initializeCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose(); // Dispose camera controller to free resources
    super.dispose();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    if (allCameras.isNotEmpty) {
      cameraController = CameraController(
        allCameras[0], // Use the first available camera
        ResolutionPreset.high,
      );
      try {
        _initializeControllerFuture = cameraController!.initialize();
      } catch (e) {
        debugPrint('Error initializing camera: $e');
      }
      setState(() {}); // Trigger a rebuild once the camera is initialized
    } else {
      debugPrint('No cameras available');
    }
  }

  // Method to add a new image with a name, position, and default size
  void _addImage(String url, String name) {
    setState(() {
      images.add({
        'url': url,
        'name': name,
        'xPosition': 100.0, // Default x position
        'yPosition': 100.0, // Default y position
        'size': 150.0, // Default size
      });
      selectedImageUrl = url; // Automatically select the new image
    });
  }

  // Display a dialog to let the user input the image URL and name
  void _showAddImageDialog() {
    final imageUrlController = TextEditingController();
    final imageNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(hintText: "Image URL"),
              ),
              TextField(
                controller: imageNameController,
                decoration: const InputDecoration(hintText: "Image Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final imageUrl = imageUrlController.text;
                final imageName = imageNameController.text;
                if (imageUrl.isNotEmpty && imageName.isNotEmpty) {
                  _addImage(imageUrl, imageName);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Method to update position and size of an image
  void _updateImageProperties(int index, double x, double y, double size) {
    setState(() {
      images[index]['xPosition'] = x;
      images[index]['yPosition'] = y;
      images[index]['size'] = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR View'),
      ),
      body: Column(
        children: [
          // AR Widget with the camera feed and overlaid images
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CameraPreview(cameraController!),
                      ),
                      // Render images as positioned widgets
                      ...images.asMap().entries.map((entry) {
                        int index = entry.key;
                        var image = entry.value;
                        return Positioned(
                          top: image['yPosition'],
                          left: image['xPosition'],
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              if (selectedImageUrl == image['url']) {
                                _updateImageProperties(
                                  index,
                                  image['xPosition'] + details.delta.dx,
                                  image['yPosition'] + details.delta.dy,
                                  image['size'],
                                );
                              }
                            },
                            onTap: () {
                              _selectImage(image['url']);
                            },
                            child: Container(
                              width: image['size'],
                              height: image['size'],
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedImageUrl == image['url']
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 3.0,
                                ),
                              ),
                              child: Image.network(image['url']),
                            ),
                          ),
                        );
                      }),
                      if (selectedImageUrl != null)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Slider(
                            value: images.firstWhere((image) =>
                                image['url'] == selectedImageUrl)['size'],
                            min: 50,
                            max: 300,
                            onChanged: (value) {
                              int index = images.indexWhere(
                                  (image) => image['url'] == selectedImageUrl);
                              _updateImageProperties(
                                index,
                                images[index]['xPosition'],
                                images[index]['yPosition'],
                                value,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                } else {
                  // Show a loading spinner while camera is initializing
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          // Bottom Navigation for adding images
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'AR View',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Image',
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                _showAddImageDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  void _selectImage(String url) {
    setState(() {
      selectedImageUrl = url;
    });
  }
}
