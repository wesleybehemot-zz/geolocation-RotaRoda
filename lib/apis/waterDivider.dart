bool returns;
String retorno = null;
String _surname;
String _name;

set setName(String value) => _name = value;

String get getSurname => _surname;
set setSurname(String value) => _surname = value;

// #region validAdress
bool validAdress(String adress) {
  if (adress != null || adress != '') {
    if (adress.length == 8 && !adress.contains(new RegExp(r'[A-Z]'))) {
      returns = true;
    } else {
      retorno += 'CEP invalído\n\r';
      print('CEP invalído');

      returns = false;
    }
  }
  return returns;
}
//#endregion

//  #region check
String check([
  String name,
  String pwd,
  String user,
  String surname,
  String email,
  String vehiclePlate,
]) {
  retorno = "";

  if (name != null && name.isEmpty) {
    if (name.length < 2) {
      retorno += ' \n\r';
      retorno += 'Faltou o nome\n\r';
    } else
      setName =
          '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';
  }

  if (surname != null && surname.isEmpty) {
    if (surname.length == null || surname.length < 3)
      retorno += 'Faltou o sobrenome\n\r';
    else
      setSurname =
          '${surname.substring(0, 1).toUpperCase()}${surname.substring(1).toLowerCase()}';
  }

  if (user != null && user.isEmpty) {
    if (user.length < 5) retorno += 'Usuario menor do que 5 digitos\n\r';
  }
  if (pwd != null || pwd.isEmpty) {
    if (pwd.length < 8) retorno += 'Senha menor que 8 digitos\n\r';

    if (!pwd.contains(new RegExp(r'[0-9]')))
      retorno += 'Falta um numero na sua senha\n\r';

    if (!pwd.contains(new RegExp(r'[A-Z]'))) {
      retorno += 'Faltou letra maiuscula na senha\n\r';
    }
  }

  if (email != null || email.isEmpty) if (!email.contains('@') &&
      !email.contains('.')) {
    retorno += 'Email invalído\n\r';
  } else {
    String splitig = email.toString().toLowerCase().trim();
    // ignore: deprecated_member_use
    var l = List();
    l = splitig.split('@');
    splitig = l[1];

    if (splitig == "gmail.com" ||
        splitig == "outlook.com" ||
        splitig == "hotmail.com" ||
        splitig == "icloud.com" ||
        splitig == "yahoo.com")
      print(email);
    else
      retorno = 'Email invalído\n\r';
  }
  if (vehiclePlate == null || vehiclePlate.isEmpty) {
    retorno += 'Placa incorreta\n\r';
  }
  print(retorno);
  if (retorno == "") retorno = null;
  return retorno;
}


//    #endregion
