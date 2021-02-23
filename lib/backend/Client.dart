import 'Service.dart';

Service serv = Service();

class Client {
  int _idUsuario = 0;

  int get idUsuario => _idUsuario;
  void set idUsuario(int value) => _idUsuario = value;

  showinf() => print('Seu registro: $idUsuario');

  pedido() {
    print('Procurando pedidos de entregas ...');
    //OS para o cliente vai vir do banco
    serv.createOs(true);

    //   print(
    //   '\n Pedidos:\n Mercado:$\n Entregador:$entregador\n Estimativa de entrega:$timeMsd ');
  }
}
