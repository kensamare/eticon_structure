import 'package:args/args.dart';
import 'package:eticon_structure/eticon_structure.dart' as eticon_structure;

///Create new cubit in project
void main(List<String> args) {
  var parser = ArgParser();
  String name = 'empty';
  String path = '';
  parser.addOption('name', callback: (val) {
    if (val != null) {
      name = val;
    }
  });
  parser.addOption('path', callback: (val) {
    if (val != null) {
      path = val;
    }
  });
  parser.parse(args);

  eticon_structure.createCubitByPath(name, path);
}
