import 'package:flutter/material.dart';
import 'package:rotaroda/configs/AppFonts.dart';
import 'package:rotaroda/models/Delivery_Driver.dart';
import '../provider/Person.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
import '../apis/via_cep.dart';

import 'package:rotaroda/apis/waterDivider.dart';

dynamic adress;
Person person = Person();

class RegisterForm extends StatefulWidget {
  final String text;

  const RegisterForm(this.text);

  @override
  _WidgetFill createState() => _WidgetFill(this.text);
}

class RegisterState extends StatefulWidget {
  _UserForm createState() => _UserForm();
}

TextEditingController namecontroler;
TextEditingController surnamecontroler;
TextEditingController emailcontroler;
TextEditingController usercontroler;
TextEditingController passwordcontroler;
TextEditingController zipcodecontroler;
TextEditingController numbercontroler;
TextEditingController veicleplate;

final Map<int, TextEditingController> controler = {
  1: namecontroler = TextEditingController(),
  2: surnamecontroler = TextEditingController(),
  3: emailcontroler = TextEditingController(),
  4: usercontroler = TextEditingController(),
  5: passwordcontroler = TextEditingController(),
  6: zipcodecontroler = TextEditingController(),
  7: numbercontroler = TextEditingController(),
  8: veicleplate = TextEditingController(),
};
TextEditingController _selectController(String component) {
  TextEditingController ted;
  if (element[1] == component) ted = controler[1];
  if (element[2] == component) ted = controler[2];
  if (element[3] == component) ted = controler[3];
  if (element[4] == component) ted = controler[4];
  if (element[5] == component) ted = controler[5];
  if (element[6] == component) ted = controler[6];
  if (element[8] == component) ted = controler[8];
  return ted;
}

//TextLabel Filds
final Map<int, String> element = {
  1: 'Name',
  2: 'Sobrenome',
  3: 'Email',
  4: 'Usuario',
  5: 'Senha',
  6: 'CEP',
  7: 'Numero',
  8: 'Placa do Veículo'
};

class _UserForm extends State<RegisterState> {
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.black,
              ),
              onPressed: () async {
                check(
                    controler[1].text.toString(),
                    controler[5].text.toString(),
                    controler[4].text.toString(),
                    controler[2].text.toString(),
                    controler[3].text.toString(),
                    controler[8].text.toString());
                //valid CEP
                if (validAdress(controler[6].text.toString()) == true) {
                  await viacep(controler[6].text.toString());
                }
                if (retorno != null || getStreet == null) {
                  error(context);
                  return;
                }
                if (retorno == null) {
                  Provider.of<Person>(context, listen: false).put(
                    Deliverydriver(
                        user: controler[4].text.toString(),
                        name:
                            '${controler[1].text.toString()} ${controler[2].text.toString()}',
                        password: controler[5].text.toString(),
                        adressJob: getStreet,
                        number: controler[7].text.toString(),
                        vehiclePlate: controler[8].text.toString(),
                        email: controler[3].text.toString()),
                  );
                }

                // if (retorno == null && getStreet.isNotEmpty ||
                //     getStreet != null)
                //   Navigator.of(context).popAndPushNamed(AppRoutes.Home);
              })
        ],
        centerTitle: true,
        shadowColor: Colors.white,
        title: Text('Cadastro',
            style: TextStyle(
              color: Colors.black, // fontFamily: AppFonts.bubblebobble
            )),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          children: [
            RegisterForm(element[1]),
            RegisterForm(element[2]),
            RegisterForm(element[3]),
            RegisterForm(element[4]),
            RegisterForm(element[5]),
            RegisterForm(element[6]),
            RegisterForm(element[8])
          ],
        ),
      ),
    );
  }
}

error(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
              title: Text('Houve Erros'),
              content: Text(
                '$retorno',
                style: TextStyle(color: Colors.red),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text(
                    'Corrigir',
                  ),
                )
              ]));
}

class _WidgetFill extends State<RegisterForm> {
  String component;
  bool valid = false;
  dynamic input;
  _WidgetFill(String component) {
    this.component = component;
  }

  @override
  Widget build(BuildContext context) {
    if (this.component == element[5]) valid = true;

    if (this.component == element[6]) {
      return Container(
        child: Row(children: <Widget>[
          //CEP TEXTFORM
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: component,
                labelStyle: TextStyle(
                  color: Colors.black,
                  // fontFamily: AppFonts.blackgroundsregular
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
              controller: _selectController(component),
              keyboardType: TextInputType.number,
            ),
          )),
          // NUMERO TEXTFORM
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Numero',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        // fontFamily: AppFonts.blackgroundsregular,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                    controller: controler[7],
                    keyboardType: TextInputType.number,
                  )))
        ]),
      );
    }
//TEXT FORM
    return (Padding(
        child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            labelText: component,
            labelStyle: TextStyle(
              color: Colors.black,
              //  fontFamily: AppFonts.blackgroundsregular,
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          controller: _selectController(component),
          obscureText: valid,
          keyboardType: input,
        ),
        padding: EdgeInsets.all(10)));
  }
}
