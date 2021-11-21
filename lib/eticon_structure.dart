library eticon_struct;

import 'dart:io';

import 'package:eticon_struct/src/creator.dart';
import 'package:eticon_struct/src/print.dart';
import 'package:eticon_struct/src/templ.dart';
import 'package:process_run/shell.dart';

///Function to create project structure
void createStructure({bool stf = false, bool withCubit = true}) async {
  printYellow('Create Project Utils...');
  if (await Directory('lib/project_utils').exists()) {
    printRed('Project Utils already exists');
    return;
  }
  Creator curDir = Creator('lib/project_utils');
  await curDir.createFile(
      fileName: 'project_colors.dart', templates: Templates.colors);
  await curDir.createFile(
      fileName: 'project_icons.dart', templates: Templates.icons);
  await curDir.createFile(
      fileName: 'project_utils.dart', templates: Templates.utils);
  printYellow('Create Project Widgets...');
  if (await Directory('lib/project_widgets').exists()) {
    printRed('Project Widgets already exists');
    return;
  }
  curDir.setDir('lib/project_widgets');
  await curDir.createFile(
      fileName: 'project_appbar.dart', templates: Templates.appBar);
  await curDir.createFile(
      fileName: 'project_text.dart', templates: Templates.text);
  await curDir.createFile(
      fileName: 'project_widgets.dart', templates: Templates.widgets);
  printYellow('Create Models...');
  if (await Directory('lib/models').exists()) {
    printRed('Models already exists');
    return;
  }
  curDir.setDir('lib/models');
  await curDir.createFile(
      fileName: 'about_models.txt', templates: Templates.about_models);
  printYellow('Create Assets...');
  if (await Directory('assets').exists()) {
    printRed('Assets already exists');
    return;
  }
  curDir.setDir('assets');
  await curDir.createFile(fileName: 'icon/empty.png', templates: '');
  await curDir.createFile(fileName: 'image/empty.png', templates: '');
  await curDir.createFile(fileName: 'fonts/empty.ttf', templates: '');
  if (!await createScreen('main', stf, withCubit)) {
    printRed('main_screen already exists');
    return;
  }
  printYellow('Remodel main.dart...');
  curDir.setDir('lib');
  await curDir.createFile(
      fileName: 'main.dart', templates: Templates.main(withCubit: withCubit));
  printYellow('Edit pubspec.yaml...');
  String ps = await File('pubspec.yaml').readAsString();
  ps = ps.substring(0, ps.lastIndexOf('flutter:'));
  ps += Templates.pubspec;
  await File('pubspec.yaml').writeAsString(ps);
  await _addLibrary();
  printGreen('Create structure success');
}

///Function to add default libraries from pub.dev
Future<void> _addLibrary() async {
  printYellow('Download packages...');
  await _downloadLibrary('eticon_api');
  await _downloadLibrary('get');
  await _downloadLibrary('flutter_screenutil');
  await _downloadLibrary('flutter_bloc');
  await _downloadLibrary('flutter_svg');
  await _downloadLibrary('get_storage');
  await _downloadLibrary('sentry_flutter');
  await _downloadLibrary('intl');
}

///Function to download libraries
Future<void> _downloadLibrary(String name) async {
  try {
    await Shell().run('flutter pub add $name');
  } catch (e) {
    return;
  }
}

///Function to create screen
Future<bool> createScreen(String name, bool stf, bool withCubit) async {
  printYellow('Create screen "$name"');
  String screenPath = 'lib/screens/${name}_screen';
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
  if (withCubit) await _createScreenCubit(name);
  printGreen('Success create screen "$name"');
  return true;
}

///Function to create screen cubit
Future<bool> _createScreenCubit(String name) async {
  name += '_screen';
  printYellow('Create screen cubit "$name"');
  String screenPath = 'lib/screens/${name}/cubit';
  if (await Directory(screenPath).exists()) {
    printRed('Cubit "$name" already exists');
    return false;
  }
  Creator curDir = Creator(screenPath);
  await curDir.createFile(
      fileName: 'st_${name}.dart', templates: Templates.cubitState(name));
  await curDir.createFile(
      fileName: 'cb_${name}.dart', templates: Templates.screenCubit(name));
  curDir.setDir('lib/screens/$name');
  await curDir.createFile(
      fileName: '${name}_provider.dart', templates: Templates.provider(name));
  return true;
}

///Function to create cubit by name and path
Future<bool> createCubitByPath(String name, String path) async {
  printYellow('Create cubit "$name"');
  if (path.isNotEmpty) {
    path += '/';
  }
  String screenPath = 'lib/${path}cubit';
  if (await File('$screenPath/cb_${name}.dart').exists()) {
    printRed('Cubit "$name" already exists');
    return false;
  }
  Creator curDir = Creator(screenPath);
  await curDir.createFile(
      fileName: 'st_${name}.dart', templates: Templates.cubitState(name));
  await curDir.createFile(
      fileName: 'cb_${name}.dart', templates: Templates.screenCubit(name));
  printGreen('Create cubit "$name" success');
  return true;
}

///Create new singleton to project_utils
Future<void> createSingleton(String name) async {
  printYellow('Create singletons "$name"');
  String screenPath = 'lib/project_utils/singletons';
  if (await File('$screenPath/sg_${name}.dart').exists()) {
    printRed('Singleton "$name" already exists');
    return;
  }
  Creator curDir = Creator(screenPath);
  await curDir.createFile(
      fileName: 'sg_${name}.dart', templates: Templates.singleton(name));
  if (await File('lib/project_utils/project_utils.dart').exists()) {
    String old =
        await File('lib/project_utils/project_utils.dart').readAsString();
    String newExport = '''export 'singletons/sg_${name}.dart';\n''';
    await File('lib/project_utils/project_utils.dart')
        .writeAsString(newExport + old);
  }
  printGreen('Create singleton "$name" success');
}
