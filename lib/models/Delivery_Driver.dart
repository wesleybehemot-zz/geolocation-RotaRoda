import 'package:flutter/widgets.dart';

class Deliverydriver {
  final String id;
  final String user;
  final String password;
  final String name;
  final String adressJob;
  final String number;
  final String vehiclePlate;
  final String email;

  const Deliverydriver(
      {this.id,
      @required this.user,
      this.password,
      @required this.number,
      @required this.name, //Name and last name Together
      @required this.adressJob,
      @required this.vehiclePlate,
      @required this.email});
}
