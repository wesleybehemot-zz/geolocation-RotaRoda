import 'dart:io';
import 'Driver.dart';
import 'Client.dart';
import 'Auxiliary.dart';
import 'apis/waterDivider.dart' as wa;

class Person extends Client with Motorista {
  String _nome,
      _retorno,
      _sobrenome,
      _email,
      _usuario,
      _senha,
      _endereco,
      _number;

  String get getUsuario => _usuario;
  set setUsuario(String value) => _usuario = value;

  set setEndereco(String value) => _endereco = value;
  String get getEndereco => _endereco;

  set setNumberAdress(String value) => _number = value;
  String get getNumberAdress => _number;

  String get getSenha => _senha;
  set setSenha(String value) => this._senha = value;

  set setNome(String value) => this._nome = value;
  String get getNome => _nome;

  set setSobrenome(String value) => _sobrenome = value;
  String get getSobrenome => _sobrenome;

  set setEmail(String value) => _email = value;
  String get getEmail => _email;

  String dado;
  bool whois;
  Suport sup = Suport();
  bool valid = false;


 


  tocall(dado) {
    sup.writing('-------------- USER -------------', Auxiliary.alllog);
    switch (int.parse(dado)) {
      case 1:
        _enter();
        _login();
        break;
      case 2:
        _register();
        // _create();

        break;

      default:
        break;
    }
    sup.writing('-------------- #USER -------------', Auxiliary.alllog);
  }

  _enter() {}

  _login() {
    dado = null;
    print('Usuario:');
    wa.whoIsCalling(stdin.readLineSync(), 'l');
    if (wa.returns == true) {
      print('Senha: ');
      wa.whoIsCalling(
        stdin.readLineSync(),
        's',
      );
      if (wa.returns == true) {
        if (Auxiliary.valid = false) print('Carregando...\n');

        if (Auxiliary.valid = true) pedido();

        sup.writing('Loging sucessful', Auxiliary.alllog);
        //Method this verify Folder create
      } else {
        sup.writing('Password incorrect', Auxiliary.alllog);
        print('Senha incorreta\n');
        _login();
      }
    } else {
      print('Usuario incorreto!\n');
      sup.writing('User incorrect', Auxiliary.alllog);
      _login();
    }
  }

  reader() {
    sup.reader();
    
  }

  _register() async {
    valid() {
      print('${wa.returns}\n\n Digite novamente o CEP:');
      wa.validadress(this.setEndereco = stdin.readLineSync());
    }

    print('Nome:');
    this.setNome = stdin.readLineSync();
    print('Sobrenome:');
    this.setSobrenome = stdin.readLineSync();
    print('Email:');
    this.setEmail = stdin.readLineSync();
    print('Usuario:');
    this.setUsuario = stdin.readLineSync();
    print('Senha:');
    this.setSenha = stdin.readLineSync();
    print('CEP:');
    this.setEndereco = stdin.readLineSync();

    wa.validadress(this.getEndereco);

    while (wa.returns == false) {
      valid();
    }
    await sup.viaCep(this.getEndereco);

    print('Numero:');
    this.setNumberAdress = stdin.readLineSync();

    //ID USUARIO RECEBENDO UM , SEM INCREMENTO
    setidUsuario = 1;

    _whyDriver();
    _create();
  }

  _whyDriver() {
    print('É um motorista? \n Sim(s) ou Não(n)');
    dado = stdin.readLineSync();

    if (dado == 'S' || dado == 's')
      _registerDriver();
    else
      return;
  }

  _registerDriver() {
    print('Placa do veículo:');
    this.setPlaca = stdin.readLineSync();
    print('Local do trabalho:');
    this.setAdressJob = stdin.readLineSync();
  }

  _showInfDriver() {
    if (this.getPlaca == '' || this.getAdressJob == '') {
      print('Digite novamente as informações');
      _registerDriver();
    } else {
      dado = '';
    }
  }

  _statusUser(String user) {
    // pega do banco de dados o atributo de status
  }

//Efetiva a criação da Pessoa seja ela motorista ou cliente

   _create() {
    //TEST
    // print(dado != 's' ? ' ' : '$dado');

    while (dado == 's') _showInfDriver();
    //// if (true
    // this.Nome != '' &&
    //     this.Senha != '' &&
    //     this.Endereco != '' &&
    //     this.Sobrenome != '' &&
    //     this.Email != '' &&
    //     this.Senha != ''
    //  ) {

    if (dado == 's' || dado == 'S') {
      wa.check(true);
      valid = true;
    }

    if (valid == true) {
      wa.check(valid, this.getNome, this.getSenha, this.getUsuario, this.getSobrenome,
          this.getEmail, this.getPlaca, this.getAdressJob);
    } else {
      wa.check(valid, this.getNome, this.getSenha, this.getUsuario, this.getSobrenome,
          this.getEmail);
    }
    if (wa.retorno != '') {
      print('-> ' + wa.retorno.toUpperCase());
      print('\n Refaça seu cadastro....');
      _register();
    }

    if (wa.returns == true) {
      print('###########################################\n');
    print('Confirmando informações: \n');
      print('Nome: ${wa.getName} Sobrenome: ${wa.getSurname}');
      print('Email: ${this.getEmail}');
      print('Usuario ${this.getUsuario}');
      print('Endereço: ${Auxiliary.getAdress} Nº: ${this.getNumberAdress}');
      showinf();

      if (dado == '' && valid == true) {
        print('Placa: ${this.getPlaca}');
        print('Local de trabalho: ${this.getAdressJob}');
      }

      print('\nUSUARIO CONFIRMADO !!!');
      print('Deseja salvar seu usuario?\n    s-Sim  n-Não');
      dado = stdin.readLineSync();

      Map usr = {'usr': "$getUsuario", 'pwd': "$getSenha", 'valid': "$valid", 'name': "$getNome"};

      save() {
        //sup.dire(Auxiliary.folderUser, Auxiliary.fileUser);
        sup.writing(usr, Auxiliary.allusr);
        print(sup.cont);

        if (sup.cont == 1) {
          sup.writing('User save sucessful', Auxiliary.alllog);
        } else {
          sup.writing('User save fail', Auxiliary.alllog);
        }
      }

      if (dado == 's' || dado == 'S')
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
      _register();
    }
  }
}
//}
