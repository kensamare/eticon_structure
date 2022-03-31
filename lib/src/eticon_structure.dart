import 'dart:convert';
import 'dart:io';

import 'package:eticon_struct/src/creator.dart';
import 'package:eticon_struct/src/metadata.dart';
import 'package:eticon_struct/src/print.dart';
import 'package:eticon_struct/src/sg_meta.dart';
import 'package:eticon_struct/src/templ.dart';
import 'package:process_run/shell.dart';
import 'package:yaml/yaml.dart';

class EticonStruct {
  final String projectDir;

  EticonStruct({this.projectDir = ''}) {
    var pubspec =
        loadYaml(File('${projectDir}pubspec.yaml').readAsStringSync());
    SgMetadata.instance.setPackName(pubspec['name']);
    // String s = loadYaml(File('${projectDir}.packages').readAsStringSync().replaceAll('file://', ''));
    // List<String> packges = s.split(' ');
    // String eticonStructPath = '';
    // for(String elm in packges){
    //   if(elm.contains('eticon_struct:')){
    //     eticonStructPath = elm.replaceAll('eticon_struct:', '');
    //     break;
    //   }
    // }
    // print(eticonStructPath);
  }

  Future<void> checkGit() async {
    try {
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('git status');
      SgMetadata.instance.setGit(true);
    } catch (e) {
      SgMetadata.instance.setGit(false);
    }
    return;
  }

  ///Function to create pj structure
  Future<int> createStructure({
    bool stf = false,
    bool withCubit = true,
    List<String> libs = const [
      'eticon_api',
      'get',
      'flutter_screenutil',
      'flutter_bloc',
      'flutter_svg',
      'get_storage',
      'sentry_flutter',
      'intl',
    ],
  }) async {
    SgMeta.instance.getL = libs.contains('get');
    SgMeta.instance.api = libs.contains('eticon_api');
    SgMeta.instance.util = libs.contains('flutter_screenutil');
    SgMeta.instance.storage = libs.contains('get_storage');
    printYellow('Create Project Utils...');
    if (await Directory('${projectDir}lib/project_utils').exists()) {
      printRed('Project Utils already exists');
      //return 1;
    }
    Creator curDir = Creator('${projectDir}lib/project_utils');
    await curDir.createFile(
        fileName: 'pj_colors.dart', templates: Templates.colors);
    await curDir.createFile(
        fileName: 'pj_icons.dart', templates: Templates.icons);
    await curDir.createFile(
        fileName: 'pj_utils.dart', templates: Templates.utils);
    printYellow('Create Project Widgets...');
    if (await Directory('${projectDir}lib/project_widgets').exists()) {
      printRed('Project Widgets already exists');
      //return 2;
    }
    curDir.setDir('${projectDir}lib/project_widgets');
    await curDir.createFile(
        fileName: 'pj_appbar.dart', templates: Templates.appBar);
    await curDir.createFile(
        fileName: 'pj_text.dart', templates: Templates.text());
    // await curDir.createFile(
    //     fileName: 'pj_widgets.dart', templates: Templates.widgets);
    printYellow('Create Models...');
    if (await Directory('${projectDir}lib/models').exists()) {
      printRed('Models already exists');
      //return 3;
    }
    curDir.setDir('${projectDir}lib/models');
    await curDir.createFile(
        fileName: 'about_models.txt', templates: Templates.about_models);
    printYellow('Create Assets...');
    if (await Directory('${projectDir}assets').exists()) {
      printRed('Assets already exists');
      //return 4;
    } else {
      curDir.setDir('${projectDir}assets');
      await curDir.createFile(fileName: 'icons/empty.png', templates: '');
      await curDir.createFile(fileName: 'images/empty.png', templates: '');
      await curDir.createFile(fileName: 'fonts/empty.ttf', templates: '');
      printYellow('Edit pubspec.yaml...');
      String ps = await File('${projectDir}pubspec.yaml').readAsString();
      ps = ps.substring(0, ps.lastIndexOf('flutter:'));
      ps += Templates.pubspec;
      await File('${projectDir}pubspec.yaml').writeAsString(ps);
    }
    if (!await createScreen('main', stf, withCubit)) {
      printRed('main_screen already exists');
      //return 5;
    } else {
      printYellow('Remodel main.dart...');
      curDir.setDir('${projectDir}lib');
      await curDir.createFile(
          fileName: 'main.dart',
          templates: Templates.main(withCubit: withCubit),
          ignorExistCheck: true);
    }
    if (SgMetadata.instance.git) {
      printYellow('Add to git...');
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('git add lib');
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('git add assets');
    }
    await _addLibrary(libs);
    printGreen('Create structure success');
    return 0;
  }

  ///Function to add default libraries from pub.dev
  Future<void> _addLibrary(List<String> libs) async {
    if (libs.isNotEmpty) {
      printYellow('Download packages...');
      for (String elm in libs) {
        await _downloadLibrary(elm);
      }
    }
    await _downloadLibrary('flutter_bloc');
    try {
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('flutter pub get');
    } catch (e) {}
    // await _downloadLibrary('eticon_api');
    // await _downloadLibrary('get');
    // await _downloadLibrary('flutter_screenutil');
    // await _downloadLibrary('flutter_bloc');
    // await _downloadLibrary('flutter_svg');
    // await _downloadLibrary('get_storage');
    // await _downloadLibrary('sentry_flutter');
    // await _downloadLibrary('intl');
  }

  ///Function to download libraries
  Future<void> _downloadLibrary(String name) async {
    try {
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('flutter pub add $name');
    } catch (e) {
      return;
    }
  }

  ///Function to create screen
  Future<bool> createScreen(String name, bool stf, bool withCubit) async {
    printYellow('Create screen "$name"');
    String screenPath = '${projectDir}lib/screens/${name}_screen';
    if (await Directory(screenPath).exists()) {
      printRed('Screen "$name" already exists');
      return false;
    }
    Creator curDir = Creator(screenPath);
    await curDir.createFile(
        fileName: '${name}_screen.dart',
        templates: stf
            ? Templates.STF(name, withCubit: withCubit)
            : Templates.STL(name, withCubit: withCubit));
    if (withCubit)
      await _createScreenCubit(name);
    else if (SgMetadata.instance.git) {
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('''git add lib/screens/${name}_screen/''');
    }
    printGreen('Success create screen "$name"');
    return true;
  }

  ///Function to create screen cubit
  Future<bool> _createScreenCubit(String name) async {
    name += '_screen';
    printYellow('Create screen cubit "$name"');
    String screenPath = '${projectDir}lib/screens/${name}/cubit';
    if (await Directory(screenPath).exists()) {
      printRed('Cubit "$name" already exists');
      return false;
    }
    Creator curDir = Creator(screenPath);
    await curDir.createFile(
        fileName: 'st_${name}.dart', templates: Templates.cubitState(name));
    await curDir.createFile(
        fileName: 'cb_${name}.dart', templates: Templates.screenCubit(name));
    curDir.setDir('${projectDir}lib/screens/$name');
    await curDir.createFile(
        fileName: '${name}_provider.dart', templates: Templates.provider(name));
    if (SgMetadata.instance.git) {
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('git add lib/screens/$name');
    }
    return true;
  }

  ///Function to create cubit by name and path
  Future<bool> createCubitByPath(String name, String path) async {
    printYellow('Create cubit "$name"');
    if (path.isNotEmpty) {
      path += '/';
    }
    String screenPath = '${path}cubit';
    if (await File('$screenPath/cb_${name}.dart').exists()) {
      printRed('Cubit "$name" already exists');
      return false;
    }
    Creator curDir = Creator(screenPath);
    await curDir.createFile(
        fileName: 'st_${name}.dart', templates: Templates.cubitState(name));
    await curDir.createFile(
        fileName: 'cb_${name}.dart', templates: Templates.screenCubit(name));
    if (SgMetadata.instance.git) {
      print(screenPath);
      await Shell(commandVerbose: false, workingDirectory: projectDir)
          .run('git add \"$screenPath\"');
    }
    printGreen('Create cubit "$name" success');
    return true;
  }

  ///Create new singleton to pj_utils
  Future<bool> createSingleton(String name) async {
    printYellow('Create singletons "$name"');
    String screenPath = '${projectDir}lib/project_utils/singletons';
    if (await File('$screenPath/sg_${name}.dart').exists()) {
      printRed('Singleton "$name" already exists');
      return false;
    }
    Creator curDir = Creator(screenPath);
    await curDir.createFile(
        fileName: 'sg_${name}.dart', templates: Templates.singleton(name));
    if (await File('${projectDir}lib/project_utils/pj_utils.dart').exists()) {
      String old = await File('${projectDir}lib/project_utils/pj_utils.dart')
          .readAsString();
      String newExport = '''export 'singletons/sg_${name}.dart';\n''';
      await File('${projectDir}lib/project_utils/pj_utils.dart')
          .writeAsString(newExport + old);
      if (SgMetadata.instance.git) {
        await Shell(commandVerbose: false, workingDirectory: projectDir)
            .run('git add lib/project_utils/singletons/sg_${name}.dart');
      }
    }
    printGreen('Create singleton "$name" success');
    return true;
  }
}
