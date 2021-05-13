import 'package:flutter/material.dart';
import 'package:rotaroda/backend/apis/push.dart';

// # TESTE
import 'ui/login.dart';
//import 'ui/register.dart';
// #####

String title;

void main() {
  runApp(Methodbuild());
  Push();
  Push().push();
}

class Methodbuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'rotaRoda',
      home: Apape(),
    );
  }
}
//     body: Center(
//       child: Column(
//         children: [

//           // Row(
//           //   FlatButton(
//           //   child: Text('Login'),
//           //   color: Colors.black,
//           //   textColor: Colors.white,
//           //   onPressed: () {},
//           // ),
//           // FlatButton(
//           //   child: Text('Cadastro'),
//           //   color: Colors.black,
//           //   textColor: Colors.white,
//           //   onPressed: () {},
//           // ),),
//         ],
//       ),
//     ),
//   );
// WidgetsFlutterBinding();
// sup.permission();
//sup.datetime();
// sup.verificFolder();
// sup.reader();
