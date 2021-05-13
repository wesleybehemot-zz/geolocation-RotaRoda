import 'package:flutter/material.dart';
import 'package:rotaroda/ui/register.dart';

class Apape extends StatefulWidget {
  @override
  _Apepe createState() => _Apepe();
}

class _Apepe extends State<Apape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("${Auxiliary.message}"),
      //   backgroundColor: Colors.black,
      // ),
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

                //[Login]
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: 'Login',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                ),
                SizedBox(height: 20.0),

                //[Password]
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  obscureText: true,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 80),
                ),
                //[Botoes]
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:34, left:70, bottom:30),
                    ),
                    // FlatButton(
                    //   child: Text("Entrar"),
                    //   color: Colors.amber,
                    //   textColor: Colors.black,
                    //   onPressed: () {},
                    // ),
                    TextButton(
                        onPressed: () {},
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
                          Register();
                        },
                        child: Text("Cadastrar"),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amber))),

                    // FlatButton(
                    //   child: Text("Cadastrar"),
                    //   color: Colors.amber,
                    //   textColor: Colors.black,
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
