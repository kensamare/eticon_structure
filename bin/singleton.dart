import 'package:args/args.dart';
import 'package:eticon_struct/eticon_struct.dart' as eticon_struct;

///Create new singletons in project_utils
void main(List<String> args) async {
  var parser = ArgParser();
  String name = 'empty';
  parser.addOption('name', callback: (val) {
    if (val != null) {
      name = val;
    }
  });
  parser.parse(args);
  eticon_struct.EticonStruct struct = eticon_struct.EticonStruct();
  await struct.checkGit();
  struct.createSingleton(name);
}
