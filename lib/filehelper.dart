import 'package:shared_preferences/shared_preferences.dart';

class Filehelper {
  static const String _imagePathsKey = 'imagePaths';

  static Future<List<String>> getImagePaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList(_imagePathsKey);
    return imagePaths ?? [];
  }

  static Future<void> addImagePaths(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagepaths = await getImagePaths();
    imagepaths.add(imagePath);
    await prefs.setStringList(_imagePathsKey, imagepaths);
  }
}
