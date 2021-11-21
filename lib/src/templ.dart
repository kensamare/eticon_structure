import 'dart:io';

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

  ///Templ project_colors.dart
  static String colors = '''
import 'package:flutter/material.dart';

class ProjectColors {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  //EN
  //Add others colors
  //RU
  //Добавляйте другие цвета
}
  ''';

  ///Templ project_icons.dart
  static String icons = '''
class ProjectIcons {
  //EN
  //Add your icons as shown below:
  //RU
  //Добавляйте свои иконки как показано ниже:
  //static String get carIcon => 'assets/icons/carIcon.svg';
  //static String get appleIcon => 'assets/icons/appleIcon.png';
}
  ''';

  ///Templ project_utils.dart
  static String utils = '''
export 'project_icons.dart';
export 'project_colors.dart';
///EN
///Add your utilities to this class, or use export
///RU
///Добавляйте свои утилиты в данный класс, или используйте export
class ProjectUtils{

}
  ''';

  ///Templ project_appbar.dart
  static String appBar = '''
import 'package:flutter/material.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ProjectAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
  ''';

  ///Templ project_text.dart
  static String text = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight; 

  const ProjectText(
      {Key? key, required this.text, this.color, this.fontSize = 14, this.fontWeight}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize!.w,
      ),
    );
  }
}
  ''';

  ///Templ project_widgets.dart
  static String widgets = '''
//EN
//Add newly created global widgets here
//RU
//Добавляйте сюда новосозданные глобальные виджеты 
export 'project_text.dart';
export 'project_appbar.dart';
  ''';

  ///Templ main.dart
  static String main({bool withCubit = true}) {
    return '''
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'screens/main_screen/main_screen${withCubit ? '_provider' : ''}.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Api.init(
      baseUrl:
          'https://your_api.com/api/v1/'); //Input your URL. Learn more eticon_api on pub.dev
  Api.loadTokenFromMemory();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), //Default size of Iphone XR and 11
      builder: () => const GetCupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MainScreen${withCubit ? 'Provider' : ''}(),
      ),
    );
  }
}
  ''';
  }

  ///Templ Stateful screen
  static String STF(String name, {bool withCubit = true}) {
    String cubit = '';
    if (withCubit) {
      cubit = '''
import 'cubit/cb_${name}_screen.dart';
import 'cubit/st_${name}_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      ''';
    }
    String className = _fileName2ClassName(name);
    String packName =
        Directory.current.toString().split('/').last.replaceAll('\'', '');
    return '''
import 'package:flutter/material.dart';
import 'package:PACK/project_utils/project_utils.dart';
import 'package:PACK/project_widgets/project_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
CUBIT

class NAMEScreen extends StatefulWidget {
  const NAMEScreen({Key? key}) : super(key: key);

  @override
  _NAMEScreenState createState() => _NAMEScreenState();
}

class _NAMEScreenState extends State<NAMEScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
    '''
        .replaceAll('NAME', className)
        .replaceAll('PACK', packName)
        .replaceAll('CUBIT', cubit);
  }

  ///Templ Stateless screen
  static String STL(String name, {bool withCubit = true}) {
    String cubit = '';
    if (withCubit) {
      cubit = '''
import 'cubit/cb_${name}_screen.dart';
import 'cubit/st_${name}_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      ''';
    }
    String className = _fileName2ClassName(name);
    String packName =
        Directory.current.toString().split('/').last.replaceAll('\'', '');
    return '''
import 'package:flutter/material.dart';
import 'package:PACK/project_utils/project_utils.dart';
import 'package:PACK/project_widgets/project_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
CUBIT

class NAMEScreen extends StatelessWidget {
  const NAMEScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
    '''
        .replaceAll('NAME', className)
        .replaceAll('PACK', packName)
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
import 'package:flutter_bloc/flutter_bloc.dart';

class CbNAME extends Cubit<StNAME> {
  CbNAME() : super(StNAMEInit());
  
  Future<void> getData() async {
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
  # The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:
     - assets/icon/
     - assets/image/

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
