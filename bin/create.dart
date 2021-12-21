import 'package:args/args.dart';
import 'package:eticon_struct/eticon_structure.dart' as eticon_struct;

///Create project structure
void main(List<String> args) async {
  var parser = ArgParser();
  bool stf = false;
  bool withCubit = true;
  parser.addFlag('stf', callback: (val) {
    stf = val;
  });
  parser.addFlag('without-cubit', callback: (val) {
    withCubit = !val;
  });
  parser.parse(args);
  eticon_struct.EticonStruct struct = eticon_struct.EticonStruct();
  await struct.checkGit();
  struct.createStructure(stf: stf, withCubit: withCubit);
}
