import 'backend/Auxiliary.dart';
import 'package:flutter/material.dart';
import 'backend/Person.dart';

Suport sup = Suport();
Auxiliary axi = Auxiliary();
Person ps = Person();

void main() {
  WidgetsFlutterBinding();
  sup.permission();
  sup.verificFolder();
  sup.reader();
  
//  sup.dateTime();

  runApp(MaterialApp(
    title: 'FirstApp',
    home: Apepe(),
  ));
}

class Apepe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo ${Auxiliary.name} '),
      ),
      body: Center(),
    );
  }
}
