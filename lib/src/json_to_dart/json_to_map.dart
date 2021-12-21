import 'create_model_file.dart';

import 'string_extension.dart';

class JsonToDart {
  static String jsonToDart(Map<String, dynamic> json, String className) =>
      jsonToClass(json, className);

  //static Map<String, dynamic> jsonToClass(
  static String jsonToClass(
      Map<String, dynamic> json, String className) {
    Map<String, dynamic> fields = {};
    Map<String, dynamic> preClass = {
      "className": className.capitalize(),
      "fileName": className.fileName
    };
    String res = '';
    List<String> imports = [];
    json.forEach((key, value) {
      if (value is List) {
        if (value.isNotEmpty) {
          // print(value[0].runtimeType);
          if (value[0] is Map<String, dynamic>) {
            fields[key.fieldName] = 'List<${key.className}Model>?';
            imports.add('${key.className}Model'.fileName);
            res += jsonToClass(value[0], '${key.className}Model');
          } else {
            fields[key.fieldName] = 'List<${_typeChecker(value[0]).replaceAll('?', '')}>?';
          }
        } else {
          fields[key.fieldName] = 'List<dynamic>?';
        }
      } else if (value is Map<String, dynamic>) {
        fields[key.fieldName] = '${key.className}Model?';
        imports.add('${key.className}Model'.fileName);
        res += jsonToClass(value, '${key.className}Model');
      } else {
        fields[key.fieldName] = _typeChecker(value);
      }
    });
    preClass['imports'] = imports;
    preClass["fields"] = fields;
    // print('Prepare ${preClass['className']}');
    // print(preClass);
    CreateModelFile model = CreateModelFile(preClass);
    
    return model.dartClass + '\n\n'+res;
  }

  static String _typeChecker(dynamic value) {
    String type = '';
    if (value is String) {
      type = 'String?';
    } else if (value is int) {
      type = 'int?';
    } else if (value is double) {
      type = 'double?';
    } else if (value is bool) {
      type = 'bool?';
    } else {
      type = 'dynamic';
    }
    return type;
  }
}
