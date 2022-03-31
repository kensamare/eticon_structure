import 'package:change_case/change_case.dart';
import 'package:eticon_struct/src/json_to_dart/fields.dart';
import 'package:eticon_struct/src/json_to_dart/metadata.dart';
import 'create_model_file.dart';

import 'string_extension.dart';

class JsonToDart {
  static String jsonToDart(Map<String, dynamic> json, String className) =>
      jsonToClass(json, className);

  //static Map<String, dynamic> jsonToClass(
  static String jsonToClass(Map<String, dynamic> json, String className) {
    //Map<String, dynamic> fields = {};
    MetaDataModel meta = MetaDataModel(
        className: className.capitalize(),
        fileName: className.fileName,
        fields: [],
        imports: []);
    // Map<String, dynamic> preClass = {
    //   "className": className.capitalize(),
    //   "fileName": className.fileName
    // };
    String res = '';
    List<String> imports = [];
    json.forEach((key, value) {
      FieldsModel field = FieldsModel();
      if (value is List) {
        if (value.isNotEmpty) {
          // print(value[0].runtimeType);
          if (value[0] is Map<String, dynamic>) {
            field.type = '${key.toPascalCase()}Model?';
            field.name = key;
            //fields[key.fieldName] = '${key.className}Model?';
            imports.add('${key.toPascalCase()}Model'.toSnakeCase());
            res += jsonToClass(value[0], '${key.toPascalCase()}Model');
            // fields[key.fieldName] = 'List<${key.className}Model>?';
            // imports.add('${key.className}Model'.fileName);
            // res += jsonToClass(value[0], '${key.className}Model');
          } else {
            field.type = 'List<${_typeChecker(value[0]).replaceAll('?', '')}>?';
            field.name = key;
            // fields[key.fieldName] =
            //     'List<${_typeChecker(value[0]).replaceAll('?', '')}>?';
          }
        } else {
          field.type = 'List<dynamic>?';
          field.name = key;
        }
      } else if (value is Map<String, dynamic>) {
        field.type = '${key.toPascalCase()}Model?';
        field.name = key;
        //fields[key.fieldName] = '${key.className}Model?';
        imports.add('${key.toPascalCase()}Model'.toSnakeCase());
        res += jsonToClass(value, '${key.toPascalCase()}Model');
      } else {
        field.type = _typeChecker(value);
        field.name = key;
        //fields[key.fieldName] = _typeChecker(value);
      }
      meta.fields.add(field);
    });
    meta.imports = imports;
    // preClass['imports'] = imports;
    // preClass["fields"] = fields;
    // print('Prepare ${preClass['className']}');
    // print(preClass);
    print(meta.toString());
    CreateModelFile model = CreateModelFile(meta);

    return model.dartClass + res;
    // return '';
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
