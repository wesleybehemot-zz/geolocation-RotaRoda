//#region oldcod

// import 'dart:collection';
// import 'dart:io';
// import 'dart:math';

// main() {
//   primaryWindows();
// }

// List<int> idUsuario = [0, 1, 2, 3, 4];
// List<String> nome = ['Cleonice', 'Enizivaldo', 'Romario', 'Maria', 'Joao'];
// List<String> endereco = [
//   'Clirice de lima Castro',
//   'Da Paz',
//   'Rua 1',
//   'Rua Sao Geronimo da Serrra',
//   'Rua 10'
// ];
// List<int> zipcode = [8671913666, 795624488, 849781266, 784514988, 78124412];
// Queue<String> client = new Queue();
// int zcode = 0;
// int id;
// double money;

// void primaryWindows() {
//   retorno() {
//     var digite;
//     return digite = int.parse(stdin.readLineSync(), onError: (String err) {
//       print('\nPor favor digite um zipcode valido!.');
//     });
//   } // recebendo valor index

//   var now = new DateTime.now();
//   print('        Seja Bem Vindo');
//   print(' ');
//   print('Hora atual: ${now.hour}:${now.minute}');
//   print('Digite o zipcode do cliente');
//   // print(retorno);
//   dynamic dados = retorno();
//   id = varrerList(imput: dados, lista: zipcode);
//   //var getRetrun = varrerList(retorno, zipcode);

//   id < idUsuario.length ? '${zcode = zipcode[id]}' : end();
//   //print('${zipcode[id]}');
//   print('Numero do cliente : $id');
//   print(' ');
// //---------------------------------------------
//   if (requestcheck() == true) {
//     client.add(nome[id]); //  fila
//     //print(client);
//     telaEntrega(client);
//   } else
//     print('Usuario nao efetuou pedido de entrega.');
// }
// //Metodos

// //Varre lista
// dynamic varrerList({dynamic imput, List lista}) {
//   int z = 0;
//   if (imput == null || imput == '') exit(0);

//   while (z < lista.length) {
//     if (imput == lista[z]) {
//       return z;
//       break;
//     } else
//       z++;
//   }
// }

// //Retirada do pedido

// //verifica pedido
// bool requestcheck() {
//   var rng = new Random();
//   bool retorno = rng.nextBool();
//   return retorno;
// }

// //Informacoes da entrega
// void telaEntrega(Queue fila) {
//   String checkout() {
//     var dados;
//     confirmout() {
//       print(' ');
//       print('Entrega feita?');
//       print(' Sim[1]  Nao[2] Cencelar[0] \n');
//       dados = int.parse(stdin.readLineSync());
//     }

//     confirmout();

//     switch (dados) {
//       case 1:
//         if (fila.first == nome[id])
//           print('Entrega Finalizada!.\nCarteira + : ${money = 12.50}');
//         break;

//       case 2:
//         confirmout();
//         break;

//       case 0:
//         print('ENTREGA CANCELADA!');
//         break;
//     }
//   }

//   print(
//       "Nome do cliente e ${fila.first} \nO endereco e: ${endereco[id]} \nDirija com cuidado! :) ");

//   checkout();
// }

// void end() {
//   print('Usuario nao existe.');
//   exit(0);
// }
// #endregion

import 'Person.dart';

class Service extends Person {
  String os;
  String client;
  String driver;
  String destinario;
  String remetente;

  createOs(bool os) {
    this.os = '1';
    this.remetente = 'Vicente';
    this.destinario = Nome;
    
    if (os) {
      print('Entrega a caminho\n');
      print('Saindo de: ${this.remetente}');
      print('Destino: ${this.destinario}');
      print('Em nome de: ${this.client}');
      print('Entregador: ${driver}');
    } else
      print('Nenhum serviço');
  }
}
