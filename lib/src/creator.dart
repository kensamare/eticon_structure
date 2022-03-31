import 'dart:io';

///Class to create files
class Creator {
  ///Directory path
  String _dirName;

  Creator(this._dirName);

  ///Set directory path
  void setDir(String dirName) {
    _dirName = dirName;
  }

  ///Function to create file
  Future<void> createFile(
      {required String fileName,
      required String templates,
      bool ignorExistCheck = false}) async {
    bool fi = fileName.contains('.');
    if (!File('$_dirName/${fi ? fileName : fileName + '.dart'}').existsSync() ||
        ignorExistCheck) {
      final file = await File('$_dirName/${fi ? fileName : fileName + '.dart'}')
          .create(recursive: true);
      file.writeAsString(templates);
    }
  }
}
