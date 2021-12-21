import 'package:args/args.dart';
import 'package:eticon_struct/eticon_structure.dart' as eticon_struct;

///Create new screen in project directory screens
void main(List<String> args) async {
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

  eticon_struct.EticonStruct struct = eticon_struct.EticonStruct();
  await struct.checkGit();
  struct.createScreen(name, stf, withCubit);
}
