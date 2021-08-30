import '../provider/Person.dart';

class Service extends Person {
  String os;
  String client;
  String driver;
  String destinario;
  String remetente;

  createOs(bool os,int i) {
    this.os = '1';
    this.remetente = 'Vicente';
    this.destinario = byIndex(i).name ;

    if (os) {
      print('Entrega a caminho\n');
      print('Saindo de: ${this.remetente}');
      print('Destino: ${this.destinario}');
      print('Em nome de: ${this.client}');
      print('Entregador: $driver');
    } else
      print('Nenhum serviço');
  }
}
