import 'package:flutter/material.dart';
import 'package:rotaroda/provider/Person.dart';
import 'package:rotaroda/source/Auxiliary.dart';
import 'package:rotaroda/routes/app_routes.dart';
import 'package:rotaroda/views/home.dart';
import 'package:provider/provider.dart';
import 'package:rotaroda/views/walcome.dart';
import 'apis/colors.dart';
import 'configs/AppFonts.dart';
import 'views/register.dart';

Suport sup = Suport();
String title;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Person(),
          )
        ],
        child: MaterialApp(
          title: 'rotaRoda',
          theme: ThemeData(
            fontFamily: AppFonts.oswald,
            primarySwatch: Colors.grey,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: AppColors.whiteGrey,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            AppRoutes.Login: (ctx) => Welcome(),
            AppRoutes.Cadastro: (ctx) => RegisterState(),
            AppRoutes.Home: (ctx) => Home(person.byIndex(0)),
          },
        ));
  }
}
