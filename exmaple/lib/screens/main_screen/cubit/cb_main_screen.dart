import 'st_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(StMainScreenInit());
  
  Future<void> getData() async {
  }
}
    