import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTheme { light, dark }

class ThemeCubit extends Cubit<AppTheme> {
  ThemeCubit() : super(AppTheme.light);

  void toggleTheme() {
    if (state == AppTheme.light) {
      emit(AppTheme.dark);
    } else {
      emit(AppTheme.light);
    }
  }
}
