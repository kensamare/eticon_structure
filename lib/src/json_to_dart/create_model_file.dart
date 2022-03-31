import 'package:eticon_struct/src/json_to_dart/fields.dart';
import 'package:eticon_struct/src/json_to_dart/metadata.dart';

import 'string_extension.dart';
import 'package:dart_style/dart_style.dart';

class CreateModelFile {
  MetaDataModel classModel;

  CreateModelFile(this.classModel);

  String get dartClass {
    if (classModel.fields.isEmpty) {
      return '';
    }
    String dartCode = '';
    dartCode += '''class ${classModel.className}{''';
    dartCode += _generateFields() + '\n\n';
    dartCode += _generateConstructor() + '\n\n';
    dartCode += _generateFromJson() + '\n\n';
    dartCode += _generateToJson();
    dartCode += '''\n
    @override
  String toString() {
    return toJson().toString();
  }
  \n''';
    dartCode += '}\n\n';
    var formatter = DartFormatter();
    // print(formatter.format(dartCode));
    return formatter.format(dartCode);
  }

  String _generateFields() {
    List<String> fileFields = [];
    for (FieldsModel field in classModel.fields) {
      fileFields.add('${field.type} ${field.name};');
    }
    // print(fileFields.join('\n'));
    return fileFields.join('\n');
  }

  String _generateConstructor() {
    List<String> constructorFields = [];

    for (FieldsModel elm in classModel.fields) {
      constructorFields.add('this.${elm.name}');
    }
    // Map<String, dynamic> fields = classModel["fields"];
    // String className = classModel['className'];
    // fields.forEach((key, value) {
    //   constructorFields.add('this.$key');
    // });
    String constructor =
        '${classModel.className}({${constructorFields.join(', ')}});';
    // print(constructor);
    return constructor;
  }

  String _generateFromJson() {
    List<String> constructorFields = [];
    for (FieldsModel elm in classModel.fields) {
      if (elm.type.isSimpleType) {
        constructorFields.add('${elm.name} = json[\'${elm.jsonField}\'];');
      } else if (elm.type.toString().isListType) {
        String generic = _getGeneric(elm.type);
        bool isModel = true;
        if ((generic + '?').isSimpleType) {
          isModel = false;
        }
        String listGen = '''
            if (json['${elm.jsonField}'] != null) {
      ${elm.name} = [];
      json['${elm.jsonField}'].forEach((v) {
        ${elm.name}!.add(${isModel ? '$generic.fromJson(v)' : 'v'});
      });
    }''';
        constructorFields.add(listGen);
      } else {
        constructorFields.add(
            '${elm.name} = json[\'${elm.jsonField}\'] != null ? ${elm.type}.fromJson(json[\'${elm.jsonField}\']) : null;');
      }
    }
    // Map<String, dynamic> fields = classModel["fields"];
    // String className = classModel['className'];
    // fields.forEach((key, value) {
    //   if (value.toString().isSimpleType) {
    //     constructorFields.add('$key = json[\'${key.jsonField}\'];');
    //   } else if (value.toString().isListType) {
    //     String generic = _getGeneric(value);
    //     bool isModel = true;
    //     if ((generic + '?').isSimpleType) {
    //       isModel = false;
    //     }
    //     String listGen = '''
    //         if (json['${key.jsonField}'] != null) {
    //   $key = [];
    //   json['${key.jsonField}'].forEach((v) {
    //     $key!.add(${isModel ? '$generic.fromJson(v)' : 'v'});
    //   });
    // }''';
    //     constructorFields.add(listGen);
    //   } else{
    //     constructorFields.add('$key = json[\'${key.jsonField}\'] != null ? $value.fromJson(json[\'${key.jsonField}\']) : null;');
    //   }
    // });
    String constructor =
        '''${classModel.className}.fromJson(Map<String, dynamic> json){
      ${constructorFields.join('\n')}
    }''';
    // print(constructor);
    return constructor;
  }

  String _generateToJson() {
    List<String> jsonFields = [];
    // Map<String, dynamic> fields = classModel["fields"];
    // String className = classModel['className'];
    for (FieldsModel elm in classModel.fields) {
      if (elm.type.isSimpleType) {
        jsonFields.add('json[\'${elm.jsonField}\'] = ${elm.name};');
      } else if (elm.type.isListType) {
        String generic = _getGeneric(elm.type);
        String list = '';
        if (!(generic + '?').isSimpleType) {
          list =
              'if(${elm.name} != null){\njson[\'${elm.jsonField}\'] = ${elm.name}!.map((v) => v.toJson()).toList();\n}';
        } else {
          list = 'json[\'${elm.jsonField}\'] = ${elm.name};';
        }
        jsonFields.add(list);
      } else {
        jsonFields.add(
            'if(${elm.name} != null){\njson[\'${elm.jsonField}\'] = ${elm.name}!.toJson();\n}');
      }
    }
    String toJson = '''Map<String, dynamic> toJson() {
      final Map<String, dynamic> json = {};
      ${jsonFields.join('\n')}
      return json;
    }''';
    // print(constructor);
    return toJson;
  }

  String _getGeneric(String type) {
    String generic = '';
    generic = type.substring(type.indexOf('<') + 1, type.indexOf('>'));
    return generic;
  }
}
