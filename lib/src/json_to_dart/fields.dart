import 'package:change_case/change_case.dart';

class FieldsModel {
  late String jsonField;
  late String _name;
  late bool isSnakeCase = true;
  late String type;

  FieldsModel(
      {this.jsonField = '',
      String name = '',
      this.isSnakeCase = true,
      this.type = ''}) {
    _name = name;
  }

  FieldsModel.fromMeta(Map<String, dynamic> json) {
    jsonField = json['json_field'];
    _name = json['name'];
    isSnakeCase = json['isSnakeCase'];
    type = json['type'];
  }

  Map<String, dynamic> toMeta() {
    final Map<String, dynamic> json = {};
    json['json_field'] = jsonField;
    json['name'] = _name;
    json['isSnakeCase'] = isSnakeCase;
    json['type'] = type;
    return json;
  }

  @override
  String toString() {
    return toMeta().toString();
  }

  String get name => _name;

  set name(String name) {
    jsonField = name;
    if (name.isLowerCase()) {
      _name = name.toCamelCase();
    } else {
      isSnakeCase = false;
      _name = name;
    }
    if (keywords.contains(_name)) {
      _name += '_';
    }
  }
}

List<String> keywords = [
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covarient',
  'default',
  'deffered',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'while',
  'with',
  'yield'
];
