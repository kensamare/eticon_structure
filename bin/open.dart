import 'dart:io';

import 'package:eticon_struct/src/print.dart';
import 'package:process_run/shell.dart';
import 'package:yaml/yaml.dart';

void main() async {
  String s = '';
  try{
    s = loadYaml(File('.packages').readAsStringSync().replaceAll('file://', ''));
  } catch (e){
    printRed('Project not found!');
    return;
  }
  List<String> packges = s.split(' ');
  String eticonStructPath = '';
  for(String elm in packges){
    if(elm.contains('eticon_struct:')){
      eticonStructPath = elm.replaceAll('eticon_struct:', '');
      break;
    }
  }
  eticonStructPath = eticonStructPath.substring(0, eticonStructPath.length-4);
  // print(eticonStructPath);
  // print(Directory.current.path.toString());
  if (Platform.isMacOS) {
    await Shell(commandVerbose: false).run('''
    open -n "${eticonStructPath}editor/eticon_desktop.app" --args ${Directory.current.path.toString() + '/'}
    ''');
  } else{
    printRed('Editor available only to macOS');
  }
}
