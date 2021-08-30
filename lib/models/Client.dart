import 'package:flutter/widgets.dart';

class Client {
  double get getidUsuario => id;

  final double id;
  final String name;
  final String adress;
  final String number;
  final String nighborhood;

  const Client({
    this.id,
    @required this.name,
    @required this.adress,
    @required this.number,
    @required this.nighborhood,
  });
}
