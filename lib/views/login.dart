import 'package:flutter/material.dart';
import 'package:rotaroda/provider/Person.dart' as person;
import 'package:rotaroda/routes/app_routes.dart';
import '../apis/assets.dart' as assets;

TextEditingController controllerlogin;
TextEditingController controllerpassword;

class Apape extends StatefulWidget {
  @override
  _Apepe createState() => _Apepe();
}

class _Apepe extends State<Apape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Column(
              children: [
                SizedBox(height: 30.0),
                Text(
                  "RotaRoda",
                  style: TextStyle(fontSize: 38),
                ),
                SizedBox(height: 90.0),

                //[Botoes]
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          //person.searchUser('login', controllerlogin.text);
                          // person.byIndex(i)
                          Navigator.of(context).popAndPushNamed(AppRoutes.Home);
                          // else
                          //   print('');
                        },
                        child: Text("Logar"),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amber))),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.Cadastro);
                      },
                      child: Text("Cadastrar"),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber)),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
