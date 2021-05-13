import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotaroda/backend/apis/waterDivider.dart';
import 'package:via_cep/via_cep.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:simple_permissions/simple_permissions.dart';

DateTime now = DateTime.now();

class Auxiliary {
  // Directory directory = ${"Directory.current  "backend/resource/user.txt""};

  static String folderUser;
  static String folderApp;
  static String folderLog;
  //  ('/storage/emulated/0/Android/data/com.locomation.lc/resource');
  static String fileUser = '/user.txt';
  static String fileLog = '/log.txt';
  static String alllog;
  static String allusr;
  static String nowTime = 'Hora ${now.hour}:${now.minute}';
  static String nowDate = 'Date ${now.day}/${now.month}/${now.year}';
  static String l;
  static String s;
  static bool valid;
  static String message;
  static String _cep, _adress, _uf, _neighborhood, _street;
  // ignore: non_constant_identifier_names
  String get Adress => _adress;
  // ignore: non_constant_identifier_names
  String get Cep => _cep;
  // ignore: non_constant_identifier_names
  String get Uf => _uf;
  // ignore: non_constant_identifier_names
  String get Neighborhood => _neighborhood;
  // ignore: non_constant_identifier_names
  String get Street => _street;
  static String getAdress = '$_street \n Bairro: $_neighborhood';
}

class Suport {
  AssetBundle assetBundle;
  RandomAccessFile raf;
  String data;
  int cont;
  Timer timer;
  bool exists;

  _dateTime() {
    // print('${Auxiliary.nowDate}');
    //  print('${Auxiliary.nowTime}');
    if (now.hour > 0) Auxiliary.message = "Bom Dia";
    if (now.hour < 23 && now.hour > 17 || now.hour == 23)
      Auxiliary.message = "Boa Noite";
    if (now.hour < 17 && now.hour > 12 || now.hour == 17)
      Auxiliary.message = "Boa Tarde";
  }

  _cFile(String filePath) {
    bool exists;
    Directory dir = Directory("$filePath");
    File file = new File('${dir.path}');

    if (file.existsSync() && filePath.isNotEmpty)
      exists = true;
    else
      exists = false;

    if (!exists) {
      file.createSync(recursive: true); // CREATE FILE
      file.existsSync()
          ? writing('File create successful ${file.path}', Auxiliary.alllog)
          : writing('Fail create file ${file.path}', Auxiliary.alllog);
    } else
      writing('File exists $filePath', Auxiliary.alllog);
  }

  _cDirectory(
    String folderPath,
  ) async {
    Directory dir = Directory(folderPath);
    exists = null;
    dir.existsSync() ? exists = true : exists = false;

    if (exists == false) {
      dir.createSync(recursive: true);
    }

    if (exists == true)
      await writing('Found $folderPath', Auxiliary.alllog);
    else
      await writing('Criando path ...', Auxiliary.alllog);
  }

  _write(var fileDate, String path) async {
    //  if (_getPermission(Permission.WriteExternalStorage) == true) {
    //await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    File file = File(path);
    cont = 0;
    _whatis(fileDate);

    if (data != '' && data != null && cont > 1) {
      raf = file.openSync(mode: FileMode.write);
      raf.writeStringSync(data);
      raf.flushSync();
      raf.closeSync();
      print('Usuario salvo com sucesso');
      cont = 1;
    }
    if (cont < 1) {
      raf = file.openSync(mode: FileMode.append);
      raf.writeStringSync('${Auxiliary.nowDate} -> $fileDate\n');
      raf.flushSync();
      raf.closeSync();
      cont = 1;
    }
    // } else
    //   print('No permission to writing files ');
  }

  // _getPermission(dynamic permission) async {
  //   bool status = await SimplePermissions.checkPermission(permission);
  //   if (!status) {
  //     var status = await SimplePermissions.requestPermission(permission);
  //     if (status == PermissionStatus.authorized) return true;
  //   }
  // }

  _read(var data, String key) async {
    //add randomacessfile in mode read
    //if (_getPermission(Permission.ReadExternalStorage) == true) {
    var file;
    if (data == Auxiliary.allusr) {
      file = File(data);

      Future<RandomAccessFile> f = file.open(mode: FileMode.append);
      f.then((RandomAccessFile raf) {
        raf.readByteSync();
      });

      if (key == 'u') {
        // TESTE DE LEITURA DE ARQUIVO JSON
        //  Map<String, dynamic> settings =
        // jsonDecode(await File(file.path).readAsString());

        // dynamic data = await rootBundle
        //     .loadString(json.decode(file.readAsString(encoding: utf8)));

        Auxiliary.l = data['usr'];
        Auxiliary.s = data['pwd'];
        Auxiliary.valid = data['valid'];
      } else
        return;
    } else {
      file = File(data);
      file.readAsLinesSync();
      print(file);
    }
    // } else
    //   print('No permission to reading files or folders');
  }

  _whatis(var file) {
    if (file.runtimeType == {}.runtimeType) {
      _jsonCreate(file);
      cont = 2;
    } else
      cont = 0;
  }

  _jsonCreate(ma) async {
    print("Criando um json");
    data = json.encode(ma).toString();
    print('Json: $data');
    exists = true;
  }

  _viacep(String date) async {
    // ignore: non_constant_identifier_names
    var CEP = new via_cep();
    var result = await CEP.searchCEP('$date', 'json', 'uper');

    if (CEP.getResponse() == 200) {
      //  print('deu certo');
      Auxiliary._cep = CEP.getCEP();
      Auxiliary._street = CEP.getLogradouro();
      Auxiliary._neighborhood = CEP.getBairro();
      Auxiliary._uf = CEP.getUF();
    } else {
      print('Código de Retorno: ' + CEP.getResponse().toString());
      print('Erro: ' + CEP.getBody());
    }
  }

  getPermissionSatus(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      getDocuments();
      if (Auxiliary.folderLog != '') {
        datetime();
        verificFolder();
        verificFile();
        // reader();
      }
    }

    if (status.isDenied) {
      print('Permissoa negada');
      getPermission(permission);
    }
  }

  getDocuments() {
    if (Platform.isAndroid) {
      Platform.environment.keys.forEach((key) {
        if (key == "EXTERNAL_STORAGE") {
          Auxiliary.folderApp = Platform.environment[key] + '/RotaRoda';
          Auxiliary.folderUser = '${Auxiliary.folderApp}/settings';
          Auxiliary.folderLog = '${Auxiliary.folderApp}/LOG';
          Auxiliary.alllog = '${Auxiliary.folderLog}${Auxiliary.fileLog}';
          Auxiliary.allusr = '${Auxiliary.folderUser}${Auxiliary.fileUser}';
          return;
        }
      });
    }
  }
  // Directory baseDir = await getApplicationDocumentsDirectory();
  // Auxiliary.folderUser = baseDir;

  dire(String direc) => _cDirectory(direc);

  file(String fil) => _cFile(fil);

  writing(var date, String path) => _write(date, path);

  // permission(dynamic permission) => _getPermission(permission);

  datetime() => _dateTime();

  verificFolder() {
    dire(Auxiliary.folderLog);
    dire(Auxiliary.folderUser);
  }

  verificFile() {
    file(Auxiliary.allusr);
    file(Auxiliary.alllog);
  }

  //Le o usuario gravado no json
  reader() => _read(Auxiliary.allusr, 'u');
  viaCep(String date) async => _viacep(date);

  void getPermission(Permission permission) async {
    if (await permission.request().isGranted) {
      getPermissionSatus(permission);
    }
  }
}
