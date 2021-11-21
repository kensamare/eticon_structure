import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'screens/main_screen/main_screen_provider.dart';

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
        home: MainScreenProvider(),
      ),
    );
  }
}
  