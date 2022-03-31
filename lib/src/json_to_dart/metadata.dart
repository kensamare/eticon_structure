import 'fields.dart';

class MetaDataModel {
  late String className;
  late String fileName;
  late List<String> imports;
  late List<FieldsModel> fields = [];

  MetaDataModel(
      {this.className = '',
      this.fileName = '',
      this.imports = const [],
      this.fields = const []});

  MetaDataModel.fromFile(Map<String, dynamic> json) {
    className = json['className'];
    fileName = json['fileName'];
    if (json['imports'] != null) {
      imports = [];
      json['imports'].forEach((v) {
        imports.add(v);
      });
    }
    if (json['fields'] != null) {
      fields = [];
      json['fields'].forEach((v) {
        fields.add(FieldsModel.fromMeta(v));
      });
    }
  }

  Map<String, dynamic> toFile() {
    final Map<String, dynamic> json = {};
    json['className'] = className;
    json['fileName'] = fileName;
    json['imports'] = imports;
    json['fields'] = fields.map((v) => v.toMeta()).toList();
    return json;
  }

  @override
  String toString() {
    return toFile().toString();
  }
}
