import 'package:args/args.dart';
import 'package:eticon_structure/eticon_structure.dart' as eticon_structure;

///Create new screen in project directory screens
void main(List<String> args) {
  var parser = ArgParser();
  String name = 'empty';
  bool stf = false;
  bool withCubit = true;
  parser.addOption('name', callback: (val) {
    if (val != null) {
      name = val;
    }
  });
  parser.addFlag('stf', callback: (val) {
    stf = val;
  });
  parser.addFlag('without-cubit', callback: (val) {
    withCubit = !val;
  });
  parser.parse(args);

  eticon_structure.createScreen(name, stf, withCubit);
}
