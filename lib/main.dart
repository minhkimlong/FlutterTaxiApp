import 'package:flutter/material.dart';
import 'package:taxi_app/Src/app_page.dart';
import 'package:taxi_app/Src/Blocs/auth_bloc.dart';
import 'package:taxi_app/Src/Resource/login_page.dart';

void main() => runApp(
      AppPage(
        new AuthBloc(),
        MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
