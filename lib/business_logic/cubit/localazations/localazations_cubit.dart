import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalazationsCubit extends Cubit<Locale> {
  LocalazationsCubit() : super(const Locale('en'));

  void changeLang(String languageCode) {
    emit(Locale(languageCode));
  }
}
