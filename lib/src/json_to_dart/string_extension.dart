extension StringExtension on String {
  String get fieldName {
    final separatedWords = split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
    var newString = '';

    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    return newString[0].toLowerCase() + newString.substring(1);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get className {
    final separatedWords = split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
    var newString = '';

    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    return newString;
  }

  String get fileName {
    return '$jsonField.dart';
  }

  String get jsonField {
    String fileName = '';
    List<String> parts = split(RegExp(r"(?=[A-Z])"));
    parts.forEach((element) {
      fileName += element.toLowerCase() + '_';
    });
    fileName = fileName.substring(0, fileName.length - 1);
    return fileName;
  }

  bool get isSimpleType {
    if (this == 'String?') {
      return true;
    } else if (this == 'int?') {
      return true;
    } else if (this == 'double?') {
      return true;
    } else if (this == 'bool?') {
      return true;
    } else if (this == 'dynamic') {
      return true;
    } else {
      return false;
    }
  }

  bool get isListType {
    if (startsWith('List<') && endsWith('>?')) {
      return true;
    } else {
      return false;
    }
  }
}
