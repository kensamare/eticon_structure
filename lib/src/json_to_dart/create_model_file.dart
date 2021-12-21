import 'string_extension.dart';
import 'package:dart_style/dart_style.dart';

class CreateModelFile {
  Map<String, dynamic> classModel;

  CreateModelFile(this.classModel);

String get dartClass{
  String dartCode = '';
  dartCode +='''class ${classModel['className']}{''';
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
  dartCode += '}';
  var formatter = DartFormatter();
  // print(formatter.format(dartCode));
  return formatter.format(dartCode);
}

  String _generateFields() {
    List<String> fileFields = [];
    Map<String, dynamic> fields = classModel["fields"];
    fields.forEach((key, value) {
      fileFields.add('$value $key;');
    });
    // print(fileFields.join('\n'));
    return fileFields.join('\n');
  }

  String _generateConstructor() {
    List<String> constructorFields = [];
    Map<String, dynamic> fields = classModel["fields"];
    String className = classModel['className'];
    fields.forEach((key, value) {
      constructorFields.add('this.$key');
    });
    String constructor = '$className({${constructorFields.join(', ')}});';
    // print(constructor);
    return constructor;
  }

  String _generateFromJson() {
    List<String> constructorFields = [];
    Map<String, dynamic> fields = classModel["fields"];
    String className = classModel['className'];
    fields.forEach((key, value) {
      if (value.toString().isSimpleType) {
        constructorFields.add('$key = json[\'${key.jsonField}\'];');
      } else if (value.toString().isListType) {
        String generic = _getGeneric(value);
        bool isModel = true;
        if ((generic + '?').isSimpleType) {
          isModel = false;
        }
        String listGen = '''
            if (json['${key.jsonField}'] != null) {
      $key = [];
      json['${key.jsonField}'].forEach((v) {
        $key!.add(${isModel ? '$generic.fromJson(v)' : 'v'});
      });
    }''';
        constructorFields.add(listGen);
      } else{
        constructorFields.add('$key = json[\'${key.jsonField}\'] != null ? $value.fromJson(json[\'${key.jsonField}\']) : null;');
      }
    });
    String constructor = '''$className.fromJson(Map<String, dynamic> json){
      ${constructorFields.join('\n')}
    }''';
    // print(constructor);
    return constructor;
  }

  String _generateToJson(){
    List<String> jsonFields = [];
    Map<String, dynamic> fields = classModel["fields"];
    String className = classModel['className'];
    fields.forEach((key, value) {
      if (value.toString().isSimpleType) {
        jsonFields.add('json[\'${key.jsonField}\'] = $key;');
      } else if (value.toString().isListType) {
        String generic = _getGeneric(value);
        String list = '';
        if (!(generic + '?').isSimpleType) {
          list = 'if($key != null){\njson[\'${key.jsonField}\'] = $key!.map((v) => v.toJson()).toList();\n}';
        } else{
          list = 'json[\'${key.jsonField}\'] = $key;';
        }
        jsonFields.add(list);
      } else{
        jsonFields.add('if($key != null){\njson[\'${key.jsonField}\'] = $key!.toJson();\n}');
      }
    });
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
