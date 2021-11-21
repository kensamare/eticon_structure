import 'package:args/args.dart';
import 'package:eticon_struct/eticon_structure.dart' as eticon_struct;

///Create new singletons in project_utils
void main(List<String> args) {
  var parser = ArgParser();
  String name = 'empty';
  parser.addOption('name', callback: (val) {
    if (val != null) {
      name = val;
    }
  });
  parser.parse(args);

  eticon_struct.createSingleton(name);
}
