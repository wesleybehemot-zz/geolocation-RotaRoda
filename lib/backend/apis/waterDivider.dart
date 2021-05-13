import 'package:rotaroda/backend/Auxiliary.dart';

bool returns = false;
String retorno = '';
String _name;
String _surname;

String get getName => _name;
set setName(String value) => _name = value;

String get getSurname => _surname;
set setSurname(String value) => _surname = value;

whoIsCalling(String data, String whoIsIt) {
  switch (whoIsIt) {
    case 'l':
      data != null ? returns = data == Auxiliary.l : returns = false;
      break;
    case 's':
      data != null ? returns = data == Auxiliary.s : returns = false;
      break;
  } //swtich
} //whoisCalling

end() {
  if (retorno == '')
    returns = true;
  else
    return;
}

validadress(String adress) {
  if (adress != null || adress != '') {
    if (adress.length == 8 && !adress.contains(new RegExp(r'[A-Z]'))) {
      returns = true;
    } else {
      print('CEP invalído');
      returns = false;
    }
  }
}

//  #region check
check(bool valid,
    [String name,
    String pwd,
    String user,
    String surname,
    String email,
    String boardcar,
    String adressjob]) {
  retorno = '';

  if (name != null && name != '') {
    if (name.length < 2)
      retorno = 'Faltou o nome\n';
    else
      setName =
          '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';
  }

  if (surname != null && surname != '') {
    if (surname.length < 0)
      retorno += 'Faltou o sobrenome\n';
    else
      setSurname =
          '${surname.substring(0, 1).toUpperCase()}${surname.substring(1).toLowerCase()}';
  }

  if (user != null && user != '') {
    if (user.length < 5) retorno += 'Usuario < do que 5 digitos\n';

    if (pwd != null || pwd != '') {
      if (pwd.length < 8) retorno += 'Senha < que 8 digitos\n';

      if (!pwd.contains(new RegExp(r'[0-9]')))
        retorno += 'falta no minimo um numero na sua senha\n';

      if (!pwd.contains(new RegExp(r'[A-Z]'))) {
        retorno += 'Adicione uma letra maiusula na sua senha\n';
      }
    }

    if (email != null || email != '') if (!email.contains('@') &&
        !email.contains('.')) {
      retorno += 'Email invalído \n';
      return;
    }

    String splitig = email.toString();
    // ignore: deprecated_member_use
    var l = List();
    l = splitig.split('@');
    splitig = l[1];

    if (splitig == ("gmail.com") ||
        splitig == ("outlook.com") ||
        splitig == ("hotmail.com") ||
        splitig == ("icloud.com") ||
        splitig == ("yahoo.com")) if (valid == false)
      end();
    else
      returns = true;
  } else {
    retorno = 'Email invalído\n';
  }

  boardcar != null || boardcar != ''
      // ignore: unnecessary_statements
      ? boardcar.length < 7
      : retorno += 'Placa incorreta \n';

  adressjob != null || adressjob != ''
      // ignore: unnecessary_statements
      ? adressjob.length < 5
      : retorno += 'Endereço esta detalhado?\n';

  //end();
}
// board_car_check(){
//   int a = board_car.Length();
//   for(int i =0; i < a;i++){
//    List letras = 'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,k,r,s,t,u,v,w,x,y,z';
//     if(board_car.sub)
//   }

//    #endregion
//check
