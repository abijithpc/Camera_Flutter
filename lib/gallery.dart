import 'dart:io';

import 'package:camera_flutter/filehelper.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late List<String> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    List<String> imagePaths = await Filehelper.getImagePaths();
    setState(() {
      _imageFiles = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
          child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10),
        itemCount: _imageFiles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Image.file(File(_imageFiles[index])),
          );
        },
      )),
    );
  }
}
