// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:camera_flutter/filehelper.dart';
import 'package:camera_flutter/gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  Future<void> _takePictures() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        await Filehelper.addImagePaths(image.path);
        print("image Captured: ${image.path}");
      }
    } catch (e) {
      print("Error Taking picture: $e");
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Camera"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Gallery()));
            },
            icon: const Icon(Icons.browse_gallery)),
      ),
      body: SafeArea(
          child: Center(
        child: ElevatedButton.icon(
            onPressed: _takePictures, label: const Text("Take Pictures")),
      )),
    );
  }
}
