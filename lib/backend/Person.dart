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

  String get Usuario => _usuario;
  void set Usuario(String value) => _usuario = value;

  void set Endereco(String value) => _endereco = value;
  String get Endereco => _endereco;

  void set Number_Adress(String value) => _number = value;
  String get Number_Adress => _number;

  String get Senha => _senha;
  void set Senha(String value) => this._senha = value;

  void set Nome(String value) => this._nome = value;
  String get Nome => _nome;

  void set Sobrenome(String value) => _sobrenome = value;
  String get Sobrenome => _sobrenome;

  void set Email(String value) => _email = value;
  String get Email => _email;

  String dado;
  bool whois;
  Suport sup = Suport();
  bool valid = false;


  getUser() {
    reader();
    Nome = Auxiliary.name;
  }

   Person() {
    getUser();
  }
// test
  tocall(dado) {
    sup.writing('-------------- USER -------------', Auxiliary.allLog);
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
    sup.writing('-------------- #USER -------------', Auxiliary.allLog);
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

        sup.writing('Loging sucessful', Auxiliary.allLog);
        //Method this verify Folder create
      } else {
        sup.writing('Password incorrect', Auxiliary.allLog);
        print('Senha incorreta\n');
        _login();
      }
    } else {
      print('Usuario incorreto!\n');
      sup.writing('User incorrect', Auxiliary.allLog);
      _login();
    }
  }

  reader() {
    sup.reader();
  }

  _register() async {
    valid() {
      print('${wa.returns}\n\n Digite novamente o CEP:');
      wa.valid_adress(this.Endereco = stdin.readLineSync());
    }

    print('Nome:');
    this.Nome = stdin.readLineSync();
    print('Sobrenome:');
    this.Sobrenome = stdin.readLineSync();
    print('Email:');
    this.Email = stdin.readLineSync();
    print('Usuario:');
    this.Usuario = stdin.readLineSync();
    print('Senha:');
    this.Senha = stdin.readLineSync();
    print('CEP:');
    this.Endereco = stdin.readLineSync();

    wa.valid_adress(this.Endereco);

    while (wa.returns == false) {
      valid();
    }
    await sup.via_Cep(this.Endereco);

    print('Numero:');
    this.Number_Adress = stdin.readLineSync();

    //ID USUARIO RECEBENDO UM , SEM INCREMENTO
    idUsuario = 1;

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
    this.placa = stdin.readLineSync();
    print('Local do trabalho:');
    this.adressJob = stdin.readLineSync();
  }

  _showInfDriver() {
    if (this.placa == '' || this.adressJob == '') {
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

  String _create() {
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
      wa.check(valid, this.Nome, this.Senha, this.Usuario, this.Sobrenome,
          this.Email, this.placa, this.adressJob);
    } else {
      wa.check(valid, this.Nome, this.Senha, this.Usuario, this.Sobrenome,
          this.Email);
    }
    if (wa.retorno != '') {
      print('-> ' + wa.retorno.toUpperCase());
      print('\n Refaça seu cadastro....');
      _register();
    }

    if (wa.returns == true) {
      print('###########################################\n');
      print('Confirmando informações: \n');
      print('Nome: ${wa.Name} Sobrenome: ${wa.Surname}');
      print('Email: ${this.Email}');
      print('Usuario ${this.Usuario}');
      print('Endereço: ${Auxiliary.getAdress} Nº: ${this.Number_Adress}');
      showinf();

      if (dado == '' && valid == true) {
        print('Placa: ${this.placa}');
        print('Local de trabalho: ${this.adressJob}');
      }

      print('\nUSUARIO CONFIRMADO !!!');
      print('Deseja salvar seu usuario?\n    s-Sim  n-Não');
      dado = stdin.readLineSync();

      Map usr = {'usr': "$Usuario", 'pwd': "$Senha", 'valid': "$valid", 'name': "$Nome"};

      save() {
        //sup.dire(Auxiliary.folderUser, Auxiliary.fileUser);
        sup.writing(usr, Auxiliary.allusr);
        print(sup.cont);

        if (sup.cont == 1) {
          sup.writing('User save sucessful', Auxiliary.allLog);
        } else {
          sup.writing('User save fail', Auxiliary.allLog);
        }
      }

      if (dado == 's' || dado == 'S')
        save();
      else {
        sup.writing('User not save ', Auxiliary.allLog);
        print(
            'Usuario não salvo\nserá preciso digitar o login a senha na proxima sessão ');
      }
    } else {
      print('\nInformações passadas estão incorretas');
      print('Digite novamente!');
      sup.writing('Error when registering new user', Auxiliary.allLog);
      _register();
    }
  }
}
//}
