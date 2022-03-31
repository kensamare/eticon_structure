import 'dart:io';

import 'package:eticon_struct/src/metadata.dart';
import 'package:eticon_struct/src/sg_meta.dart';

///Templates class, to generate project files
class Templates {
  ///Templ about models
  static String about_models = '''
EN
Use Json2Dart to create your models
RU
Используйте Json2Dart чтобы создать свои модели
Example(Пример):

class User {
  String? name;
  String? lastName;
  String? phone;

  User({this.name, this.lastName, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['last_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    return data;
  }
}
  ''';

  ///Templ pj_colors.dart
  static String colors = '''
import 'package:flutter/material.dart';

class PjColors {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  //EN
  //Add others colors
  //RU
  //Добавляйте другие цвета
}
  ''';

  ///Templ pj_icons.dart
  static String icons = '''
class PjIcons {
  //EN
  //Add your icons as shown below:
  //RU
  //Добавляйте свои иконки как показано ниже:
  //static String get carIcon => 'assets/icons/carIcon.svg';
  //static String get appleIcon => 'assets/icons/appleIcon.png';
}
  ''';

  ///Templ pj_utils.dart
  static String utils = '''
export 'pj_icons.dart';
export 'pj_colors.dart';
///EN
///Add your utilities to this class, or use export
///RU
///Добавляйте свои утилиты в данный класс, или используйте export
class PjUtils{

}
  ''';

  ///Templ pj_appbar.dart
  static String appBar = '''
import 'package:flutter/material.dart';

class PjAppBar extends StatelessWidget implements PreferredSizeWidget{
  const PjAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
  ''';

  ///Templ pj_text.dart
  static String text() {
    print(SgMeta.instance.util);
    return '''
import 'package:flutter/material.dart';${SgMeta.instance.util ? '''\nimport 'package:flutter_screenutil/flutter_screenutil.dart';''' : ''}

class PjText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight; 

  const PjText(
      {Key? key, required this.text, this.color, this.fontSize = 14, this.fontWeight}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize!${SgMeta.instance.util ? '.w' : ''},
      ),
    );
  }
}
  ''';
  }

  ///Templ pj_widgets.dart
  static String widgets = '''
//EN
//Add newly created global widgets here
//RU
//Добавляйте сюда новосозданные глобальные виджеты 
export 'pj_text.dart';
export 'pj_appbar.dart';
  ''';

  ///Templ main.dart
  static String main({bool withCubit = true}) {
    String mainUtil = '''return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => ${SgMeta.instance.getL ? 'Get' : ''}CupertinoApp(
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!);
        },
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const MainScreen${withCubit ? 'Provider' : ""}(),
      ),
    );
    ''';
    String mainClear =
        '''return ${SgMeta.instance.getL ? 'Get' : ''}CupertinoApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MainScreen${withCubit ? 'Provider' : ""}(),
    );
    ''';

    return '''
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';${SgMeta.instance.util ? '''\nimport 'package:flutter_screenutil/flutter_screenutil.dart';''' : ''}${SgMeta.instance.getL ? '''\nimport 'package:get/get.dart';''' : ''}${SgMeta.instance.storage ? '''\nimport 'package:get_storage/get_storage.dart';''' : ''}${SgMeta.instance.api ? '''\nimport 'package:eticon_api/eticon_api.dart';''' : ''}
import 'screens/main_screen/main_screen${withCubit ? '_provider' : ''}.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ${SgMeta.instance.storage ? '''await GetStorage.init();''' : ''}
  ${SgMeta.instance.api ? '''  Api.init(
      baseUrl:
          'https://your_api.com/api/v1/'); //Input your URL. Learn more eticon_api on pub.dev''' : ''}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ${SgMeta.instance.util ? mainUtil : mainClear}
  }
}
  ''';
  }

  ///Templ Stateful screen
  static String STF(String name, {bool withCubit = true}) {
    String cubit = '';
    String builder = '';
    if (withCubit) {
      cubit = '''
import 'cubit/cb_${name}_screen.dart';
import 'cubit/st_${name}_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      ''';
      builder = '''return Scaffold(
      appBar: const PjAppBar(),
      body: BlocBuilder<CbNAMEScreen, StNAMEScreen>(
        builder: (context, state){
          if(state is StNAMEScreenLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is StNAMEScreenLoaded){
            return Container(color: Colors.green);
          }
          if(state is StNAMEScreenError){
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
      ''';
    }
    String className = _fileName2ClassName(name);
    return '''
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:${SgMetadata.instance.packName}/project_utils/pj_utils.dart';
import 'package:${SgMetadata.instance.packName}/project_widgets/pj_appbar.dart';${SgMeta.instance.util ? '''\nimport 'package:flutter_screenutil/flutter_screenutil.dart';''' : ''}${SgMeta.instance.getL ? '''\nimport 'package:get/get.dart';''' : ''}
CUBIT

class NAMEScreen extends StatefulWidget {
  const NAMEScreen({Key? key}) : super(key: key);

  @override
  _NAMEScreenState createState() => _NAMEScreenState();
}

class _NAMEScreenState extends State<NAMEScreen> {
  @override
  Widget build(BuildContext context) {
    ${withCubit ? builder : 'return Container();'}
  }
}
    '''
        .replaceAll('NAME', className)
        .replaceAll('CUBIT', cubit);
  }

  ///Templ Stateless screen
  static String STL(String name, {bool withCubit = true}) {
    String cubit = '';
    String builder = '';
    if (withCubit) {
      cubit = '''
import 'cubit/cb_${name}_screen.dart';
import 'cubit/st_${name}_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      ''';
      builder = '''return Scaffold(
      appBar: const PjAppBar(),
      body: BlocBuilder<CbNAMEScreen, StNAMEScreen>(
        builder: (context, state){
          if(state is StNAMEScreenLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is StNAMEScreenLoaded){
            return Container(color: Colors.green);
          }
          if(state is StNAMEScreenError){
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
      ''';
    }
    String className = _fileName2ClassName(name);
    return '''
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:${SgMetadata.instance.packName}/project_utils/pj_utils.dart';
import 'package:${SgMetadata.instance.packName}/project_widgets/pj_appbar.dart';${SgMeta.instance.util ? '''\nimport 'package:flutter_screenutil/flutter_screenutil.dart';''' : ''}${SgMeta.instance.getL ? '''\nimport 'package:get/get.dart';''' : ''}
CUBIT

class NAMEScreen extends StatelessWidget {
  const NAMEScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ${withCubit ? builder : 'return Container();'}
  }
}
    '''
        .replaceAll('NAME', className)
        .replaceAll('CUBIT', cubit);
  }

  ///Templ Cubit States
  static String cubitState(String name) {
    String className = _fileName2ClassName(name);
    return '''
abstract class StNAME{}

class StNAMEInit extends StNAME{}

class StNAMELoaded extends StNAME{}

class StNAMELoading extends StNAME{}

class StNAMENoAuthError extends StNAME{}

class StNAMENoInternetError extends StNAME {}

class StNAMEError extends StNAME{
  final int? error;
  final String? message;
  StNAMEError({this.error,this.message});
}
    '''
        .replaceAll('NAME', className);
  }

  ///Templ Cubit
  static String screenCubit(String name) {
    String className = _fileName2ClassName(name);
    return '''
import 'st_FILE.dart';
import 'package:flutter_bloc/flutter_bloc.dart';${SgMeta.instance.api ? '''\nimport 'package:eticon_api/eticon_api.dart';''' : ''}

class CbNAME extends Cubit<StNAME> {
  CbNAME() : super(StNAMELoading());
  
  Future<void> getData() async {
  ${SgMeta.instance.api ? '''try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StNAMELoaded());
    } on APIException catch (e) {
      emit(StNAMEError(error: e.code));
    }''' : ''}
  }
}
    '''
        .replaceAll('NAME', className)
        .replaceAll('FILE', name);
  }

  ///Templ BlocProvider
  static String provider(name) {
    String className = _fileName2ClassName(name);
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '${name}.dart';
import 'cubit/cb_${name}.dart';
import 'cubit/st_${name}.dart';

class ${className}Provider extends StatelessWidget {
  const ${className}Provider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Cb${className}>(
      create: (context) => Cb${className}(),
      child: const $className(),
    );
  }
}    
    ''';
  }

  ///Templ end of pubspec.yaml
  static String pubspec = '''
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:
     - assets/icons/
     - assets/images/

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages
  ''';

  ///Templ of singleton
  static String singleton(String name) {
    String className = _fileName2ClassName(name);
    return '''
class Sg$className {
  Sg$className._();

  static Sg$className instance = Sg$className._();
  
  static int cnt = 0; //some variables 
  
  //Some Method
  void inc(){
    cnt++;
  }
}''';
  }

  ///Function to convert file name to class name
  static String _fileName2ClassName(String name) {
    List<String> nameList = name.split('_');
    String className = '';
    for (String elm in nameList) {
      className += elm.capitalize();
    }
    return className;
  }
}

///Extension string class to add capitalize
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
