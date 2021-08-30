import 'package:flutter/material.dart';
import 'package:rotaroda/models/Delivery_Driver.dart';
import '../source/Auxiliary.dart';
import '../provider/Person.dart';

class Home extends StatelessWidget {
  final Deliverydriver deliverydriver;
  const Home(this.deliverydriver);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Auxiliary.message} ${deliverydriver.name}'),
      ),
    );
  }
}
