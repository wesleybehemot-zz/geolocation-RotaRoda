import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:via_cep/via_cep.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

DateTime now = DateTime.now();

class Auxiliary {
  static var path = Directory.current.path + "user.txt";
 // Directory directory = ${"Directory.current  "backend/resource/user.txt""};

  static String folderUser = path ;
  static String folderLog = folderUser;
  //  ('/storage/emulated/0/Android/data/com.locomation.lc/resource');
  static String fileUser = ('/user.txt');

  static String fileLog = ('/log.txt');
  static String allLog = '${folderLog}${fileLog}';
  static String allusr = '${folderUser}${fileUser}';

  String nowTime = 'Hora ${now.hour}:${now.minute}';
  String nowDate = 'Date ${now.day}/${now.month}/${now.year}';
  static String l;
  static String s;
  static bool valid;
  static String name;

  static String _cep, _adress, _uf, _neighborhood, _street;
  String get Cep => _cep;
  String get Adress => _adress;
  String get Uf => _uf;
  String get Neighborhood => _neighborhood;
  String get Street => _street;

  static String getAdress = '$_street \n Bairro: ${_neighborhood}';
}

class Suport {
  AssetBundle assetBundle;
  RandomAccessFile raf;
  String data = null;
  int cont;
  bool exists;

  verificFolder() {
    dire(Auxiliary.folderLog, Auxiliary.fileLog);
    dire(Auxiliary.folderUser, Auxiliary.fileUser);
  }

  dateTime() {
    print('${Auxiliary().nowDate}');
    print('${Auxiliary().nowTime}');
  }

  _cDirectory(String folderPath, String filePath) async {
    // await assetBundle.load(filePath);
    Directory dir = Directory(Auxiliary.folderUser);

    print("O PATH DA FOLDER ${dir.path}");

    // load_path() async{
    await rootBundle.load(filePath);
    await rootBundle.load(dir.path);
    // }

    dir.existsSync() ? exists = true : exists = false;
    if (exists == true)
      writing('Found ${folderPath}', Auxiliary.allLog);
    else
      writing('Criando path ...', Auxiliary.allLog);

    if (exists == false) {
      (dir.createSync(recursive: true)); //CREATE DIRECTORY
      writing('Create sucessful ${folderPath}', Auxiliary.allLog);
    }

    File file = new File('${dir.path}${filePath}');

    print("O PATH DO FILE ${file.path}");

    file.existsSync() ? exists = true : exists = false;
    if (!exists) {
      file.createSync(recursive: true); // CREATE FILE
      file.existsSync()
          ? writing('File create successful ${file.path}', Auxiliary.allLog)
          : writing('Fail create file ${file.path}', Auxiliary.allLog);
    } else
      writing('File exists ${filePath}', Auxiliary.allLog);
  }

  _write(var fileDate, String path) async {
    //bool isShown = await Permission.contacts.shouldShowRequestRationale;
    //if (!isShown) permission();
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
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
        raf.writeStringSync('${Auxiliary().nowDate} -> $fileDate\n');
        raf.flushSync();
        raf.closeSync();
        cont = 1;
      }
    } else {
      print('Sem permissao para executar');
    }
  }

  _getPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      return status;
    }
  }

  _read(var data, String key) async {
    //add randomacessfile in mode read
    var file;
    if (data == Auxiliary.allusr) {
      file = File(data);

      Future<RandomAccessFile> f = file.open(mode: FileMode.append);
      f.then((RandomAccessFile raf) {
        raf.readByteSync();
      });

      if (key == 'u') {
        dynamic data = await rootBundle
            .loadString(json.decode(file.readAsString(encoding: utf8)));

        Auxiliary.l = data['usr'];
        Auxiliary.s = data['pwd'];
        Auxiliary.valid = data['valid'];
        Auxiliary.name = data['name'];
      } else
        return;
    } else {
      file = File(data);
      file.readAsLinesSync();
      print(file);
    }
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

  dynamic getDocuments() async {
    Directory baseDir = await getApplicationDocumentsDirectory();
    return baseDir;
  }

  dire(String direc, String fil) => _cDirectory(direc, fil);
  writing(var date, String path) => _write(date, path);
  permission() => _getPermission();
  //Le o usuario gravado no json
  reader() => _read(Auxiliary.allusr, 'u');
  via_Cep(String date) async => _viacep(date);
}
