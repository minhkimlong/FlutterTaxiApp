import 'package:flutter/material.dart';
import 'package:taxi_app/Src/Blocs/auth_bloc.dart';

class AppPage extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;

  AppPage(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static AppPage of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppPage);
  }
}
