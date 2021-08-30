import 'package:flutter/cupertino.dart';
import 'package:rotaroda/apis/waterDivider.dart';
import 'package:rotaroda/views/register.dart';
import 'package:via_cep/via_cep.dart';

String _cep, _adress, _uf, _neighborhood, _street;

set setAdress(String value) => _adress = value;
set setCep(String value) => _cep = value;
set setUf(String value) => _uf = value;
set setNeighborhood(String value) => _neighborhood = value;
set setStreet(String value) => _street = value;
String get getAdress => _adress;
String get getCep => _cep;
String get getUf => _uf;
String get getNeighborhood => _neighborhood;
String get getStreet => _street;
String getAdressAll = ' $getStreet \n Bairro: $getNeighborhood';

viacep(String date) async {
  // ignore: non_constant_identifier_names
  var CEP = new via_cep();
  await CEP.searchCEP('$date', 'json', 'uper');

  if (CEP.getResponse() == 200) {
    setCep = CEP.getCEP();
    setStreet = CEP.getLogradouro();
    setNeighborhood = CEP.getBairro();
    setUf = CEP.getUF();
  } else {
    retorno = 'Código de Retorno: ' + CEP.getResponse().toString();
    print('Código de Retorno: ' + CEP.getResponse().toString());
    print('Erro: ' + CEP.getBody());
    print(getStreet);
  }
  if (CEP.getCEP() == null) {
    retorno = 'CEP invalido ';
    print('$date = ' + getStreet);
  }
}
