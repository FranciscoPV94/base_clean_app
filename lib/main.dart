import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/bloc_observer.dart';
import 'core/dependencies_injection.dart';
import 'presentation/app/app.dart';

void main() {
  injectDependencies();
  Bloc.observer = GlobalBlocObserver();
  runApp(const App());
}
