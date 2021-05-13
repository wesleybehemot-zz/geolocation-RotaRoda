import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        // [BACK HOME]
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],

        // leading:
        // }),

        //[GO DESHBORD]
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.arrow_forward,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
        centerTitle: true,
        shadowColor: Colors.red,
        title: Text(
          'Cadastro',
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          children: [
            Fill('Nome'),
            //  setState((){}),
            Fill('Sobrenome'),
            Fill('Email'),
            Fill('Usuario'),
            Fill('Senha'),
            Fill('Cep'),
          ],
        ),
      ),
    );
  }
}

class _Fill extends State<Fill> {
  String component;
  bool valid = false;
  dynamic input;
  _Fill(String component) {
    this.component = component;
  }

  @override
  Widget build(BuildContext context) {
    if (this.component == 'Senha') valid = true;
    if (this.component == 'Cep') input = TextInputType.number;

    return (Padding(
        child: TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            labelText: component,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),

          //   obscureText: valid,
          keyboardType: input,
        ),
        padding: EdgeInsets.all(10)));
  }
}

// child: Decoration
//     SizedBox(height: 30,),
//     TextField(
//       decoration: InputDecoration(
//         labelText:'Nome',
//       ),
//     ),
//     ),

class Fill extends StatefulWidget {
  final String text;
  const Fill(this.text);

  _Fill createState() => _Fill(this.text);
}
