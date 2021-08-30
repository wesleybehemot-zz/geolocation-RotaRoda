import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:rotaroda/apis/assets.dart' as assets;
import 'package:rotaroda/views/register.dart';
import '../source/Auxiliary.dart';
import '../models/Delivery_Driver.dart';

String id, user, password, number, name, adressJob, vehiclePlate, email;
Map<String, Deliverydriver> dummy_user_static;
Map dvm = {}; //deliverydriver
Map urm = {}; //user
Map<String, Deliverydriver> deli = {};
List aaaa;
loadUserJson(var type) async {
  var data = await rootBundle.loadString(assets.userJson);
  dummy_user_static = json.decode(data);
  deliDriver(dummy_user_static);
}

// CARREGADO O JSON em variaveis
deliDriver(Map a) {
  a.keys.forEach((element) {
    if (element == assets.typePerson[1]) {
      Map aaa = a[element];
      aaa[0]
          ? RangeError.index(0, '1')
          : aaa.forEach((key, value) {
              switch (key) {
                case "id":
                  {
                    dvm["id"] = value;
                    break;
                  }
                case "user":
                  {
                    dvm["user"] = value;
                    break;
                  }
                case "password":
                  {
                    dvm["password"] = value;
                    break;
                  }
                case "number":
                  {
                    dvm["number"] = value;
                    break;
                  }
                case "name":
                  {
                    dvm["name"] = value;
                    break;
                  }
                case "adressJob":
                  {
                    dvm["adressJob"] = value;
                    break;
                  }
                case "vehiclePlate":
                  {
                    dvm["vehiclePlate"] = value;
                    break;
                  }
                case "email":
                  {
                    dvm["email"] = value;
                    break;
                  }
              }
            });
    }
  });
}

// CADA CHAMAEDA E  FEITA INDIVIDUALMENTE
// [regras]
// deliDriver();
// [regras]
// userLIst();

//############# DELIVERY DRIVER ##################

// deli.putIfAbsent(
//     id,
//     () => Deliverydriver(
//         id: id,
//         user: user,
//         password: password,
//         number: number,
//         name: name,
//         adressJob: adressJob,
//         vehiclePlate: vehiclePlate,
//         email: email));

// run(Map<dynamic, dynamic> oo) {
//   oo.forEach((key, value) {
//     print('key:$key: value:$value');
//   });
// }

// run(person.dummyUser);
// for (var i = 0; i < person.count; i++) {
//   print('nome do motorista ${person.byIndex(i).name}');
// }

//#############  USUARIOS ##################
userList() {
  // person.dummy_user[1] = {
  //   'id': id,
  //   'user': user,
  //   'number': number,
  //   'name': name,
  //   'adressJob': adressJob,
  //   'vehiclePlate': vehiclePlate,
  //   'email': email
  // };

  // person.dummy_user[1].putIfAbsent(
  //     int.parse(id),
  //     () => Deliverydriver(
  //         id: id,
  //         user: user,
  //         password: password,
  //         number: number,
  //         name: name,
  //         adressJob: adressJob,
  //         vehiclePlate: vehiclePlate,
  //         email: email));

  // searchUser(String value, var key) {
//   switch (aaa[key].containsValue(value)) {
//     case true:
//       {
//         print('USUARIO ENCONTRADO\nid: ${aaa[key]['id']}');
//         break;
//       }
//     case false:
//       {
//         print('USUARIO NAO ENCONTRADO!');
//         break;
//       }
// String u = byIndex(i).user;
// String p = byIndex(i).password;
//_login
//  }
//}
}

class Person extends Deliverydriver with ChangeNotifier {
//#region  Atributos
  bool valid;
  Map<String, Deliverydriver> dummyUser = {};
  Suport sup = Suport();

//#endregion

//Carrega lista de clientes

  // Retorna uma lista clone de usuarios
  List get all {
    return [...dummyUser.values];
  }

  int get count {
    return dummyUser.length;
  }

  Deliverydriver byIndex(int i) {
    return dummyUser.values.elementAt(i);

    // return dummyUser.values.elementAt(i);
  }

  put(Deliverydriver dv) {
    String identif;
    if (dv == null) return;
    //update user
    if (dv.id != null &&
        dv.id.trim().isNotEmpty &&
        dummyUser.containsKey(dv.id)) {
      dummyUser.update(
        dv.id,
        (value) => Deliverydriver(
            id: dv.id,
            user: dv.user,
            password: password,
            name: dv.name,
            adressJob: dv.adressJob,
            number: dv.number,
            vehiclePlate: dv.vehiclePlate,
            email: dv.email),
      );
    } else {
      //Add user
      identif = Random().nextDouble().toString();
      dummyUser.putIfAbsent(
        identif,
        () => Deliverydriver(
            id: identif,
            user: dv.user,
            name: dv.name,
            password: dv.password,
            adressJob: dv.adressJob,
            number: dv.number,
            vehiclePlate: dv.vehiclePlate,
            email: dv.email),
      );
    }
    notifyListeners();

    dvm = {
      "id": identif,
      "user": dv.user,
      "name": dv.name,
      "password": dv.password,
      "adressJob": dv.adressJob,
      "number": dv.number,
      "vehiclePlate": dv.vehiclePlate,
      "email": dv.email
    };
    urm = {};
    var jsonFile = "{'User':[{$urm}],'DeliveryDriver':[{$dvm}]}";
    Suport().writing(
      jsonFile,
      Auxiliary.fileUser,
    );
  }

  void remove(Deliverydriver dv) {
    if (dv != null && dv.id != null) {
      dummyUser.remove(dv.id);
      notifyListeners();
    }
  }

  signIn(String u, String s, int i) => _login(u, s, i);

  bool _login(String u, String s, [int i]) {
    if (byIndex(i).user == u) valid = true;
    if (byIndex(i).password == s && valid == true) valid = true;
    if (valid == true)
      sup.writing('Loging sucessful', Auxiliary.alllog);
    else
      sup.writing('Login Fail', Auxiliary.alllog);

    return valid;
  }
}
