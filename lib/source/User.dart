import 'dart:math';

import 'package:rotaroda/models/Delivery_Driver.dart';
import 'Auxiliary.dart';
import '../apis/via_cep.dart';
import '../apis/waterDivider.dart' as wa;

class User extends Deliverydriver {
  String date;
  bool whois;
  Suport sup = Suport();
  bool valid = false;

  signIn(String u, String s) => _login;
  signUp() => _register();

  bool _login(String u, String s) {
    valid = false;
    searchUser(Auxiliary.allusr, 'u');

    if (Auxiliary.l == u) valid = true;
    if (Auxiliary.s == s && valid == true) valid = true;
    if (valid == true)
      sup.writing('Loging sucessful', Auxiliary.alllog);
    else
      sup.writing('Login Fail', Auxiliary.alllog);
  }

  searchUser(String path, String key) {
    sup.reader(path, key);
  }

  _create() {
    if (wa.returns == true) {
      print('###########################################\n');
      print('id: ${this.id}');
      print('Confirmando informações: \n');
      print('Nome: ${this.name}');
      print('Email: ${this.email}');
      print('Usuario ${this.user}');
      print('Endereço: $getAdressAll');
      print('Placa: $vehiclePlate');
      print('Local de trabalho: $adressJob');

      print('\nUSUARIO CONFIRMADO !!!');
      print('Deseja salvar seu usuario?\n    s-Sim  n-Não');
      date = 's';

     

      save() {
        if (sup.cont == 1) {
          sup.writing('User save sucessful', Auxiliary.alllog);
        } else {
          sup.writing('User save fail', Auxiliary.alllog);
        }
      }

      if (date == 's' || date == 'S')
        save();
      else {
        sup.writing('User not save ', Auxiliary.alllog);
        print(
            'Usuario não salvo\nserá preciso digitar o login a senha na proxima sessão ');
      }
    } else {
      print('\nInformações passadas estão incorretas');
      print('Digite novamente!');
      sup.writing('Error when registering new user', Auxiliary.alllog);
    }
  }

  _register() async {
    await viacep(getAdress);
    getStreet == null || getStreet.isEmpty
        ? print('Falha ao encontrar endereco.')
        : print('Endereco recuperado');
    _create();
  }
}
