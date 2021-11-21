import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen.dart';
import 'cubit/cb_main_screen.dart';
import 'cubit/st_main_screen.dart';

class MainScreenProvider extends StatelessWidget {
  const MainScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbMainScreen>(
      create: (context) => CbMainScreen(),
      child: const MainScreen(),
    );
  }
}    
    