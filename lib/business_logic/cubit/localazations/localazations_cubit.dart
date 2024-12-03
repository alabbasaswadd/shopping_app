import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'localazations_state.dart';

class LocalazationsCubit extends Cubit<Locale> {
  LocalazationsCubit() : super(const Locale('en'));
  static Locale locale = Locale("ar");
  Locale changeLang(String languageCode) {
    emit(Locale(languageCode));
    locale = Locale(languageCode);
    return locale;
  }
}
