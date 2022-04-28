
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_flutter/src/app.dart';
import 'package:hero_flutter/src/bloc/app_bloc_observer.dart';
import 'package:hero_flutter/src/demo.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
  // runApp(Demo());
}



