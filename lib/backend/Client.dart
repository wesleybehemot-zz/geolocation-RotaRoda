import 'Service.dart';

Service serv = Service();

class Client {
  int _idUsuario = 0;

  int get getidUsuario => _idUsuario;
  set setidUsuario(int value) => _idUsuario = value;

  showinf() => print('Seu registro: $getidUsuario');

  pedido() {
    print('Procurando pedidos de entregas ...');
    //OS para o cliente vai vir do banco
    serv.createOs(true);

    //   print(
    //   '\n Pedidos:\n Mercado:$\n Entregador:$entregador\n Estimativa de entrega:$timeMsd ');
  }
}
