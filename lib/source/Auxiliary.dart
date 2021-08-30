import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

DateTime now = DateTime.now();

class Auxiliary {
  static String folderUser;
  static String folderApp;
  static String folderLog;
  static String fileUser = '/lib/data/user.json';
  static String fileLog = '/log.txt';
  static String alllog;
  static String allusr;
  static String nowTime = 'Hora ${now.hour}:${now.minute}';
  static String nowDate = 'Date ${now.day}/${now.month}/${now.year}';
  static String l;
  static String s;
  static bool valid;
  static String message;
  static List<String> environment = ["EXTERNAL_STORAGE", "DOWNLOAD_CACHE"];

  static Future<String> loadAVaultAsset() async {
    return await rootBundle.loadString(fileUser);
  }
}

class Suport {
  RandomAccessFile raf;

  int cont;
  bool exists;

  _dateTime() {
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
      print(exists);
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
    print(exists);
    if (exists == false) {
      dir.createSync(recursive: true);
    }

    if (exists == true)
      await writing('Found $folderPath', Auxiliary.alllog);
    else
      await writing('Criando path ...', Auxiliary.alllog);
  }

  _write(var fileDate, String path) {
    File file = File(path);
    cont = 0;
    var data = _whatis(fileDate);

    //save user json file
    if (data != '' && data != null && data == Auxiliary.loadAVaultAsset()) {
      raf = file.openSync(mode: data.append);
      raf.writeStringSync(data);
      raf.flushSync();
      raf.closeSync();
      print('Usuario salvo com sucesso');
      cont = 1;
    }
    //save log text file
    if (fileDate != '' && fileDate.isNotEmpty && path == Auxiliary.alllog) {
      raf = file.openSync(mode: FileMode.append);
      raf.writeStringSync('${Auxiliary.nowDate} -> $fileDate\n');
      raf.flushSync();
      raf.closeSync();
      cont = 1;
    }
  }

  _read(var data, String key) {
    var file;
    if (data == Auxiliary.allusr) {
      file = File(data);

      Future<RandomAccessFile> f = file.open(mode: FileMode.append);
      f.then((RandomAccessFile raf) {
        raf.readByteSync();
      });

      //read User Json file
      if (key == 'u') {
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
  }

  _whatis(var file) {
    if (file.runtimeType == <String, dynamic>{}.runtimeType) {
      var j = file.toString();
      cont = 2;
      print("Criando um json");
      dynamic retorno = json.encode(j).toString();
      print('Json: $retorno');
      return retorno;
    } else
      cont = 0;
  }

  static getDocuments() {
    if (Platform.isAndroid) {
      Platform.environment.keys.forEach((key) {
        if (key == Auxiliary.environment[0]) {
          Auxiliary.folderApp = Platform.environment[key] + '/RotaRoda';
          //Auxiliary.folderUser = '${Auxiliary.folderApp}/settings';
          Auxiliary.folderLog = '${Auxiliary.folderApp}/LOG';
          Auxiliary.alllog = '${Auxiliary.folderLog}${Auxiliary.fileLog}';
          print(key);
        }
        return;
      });
    }
  }

  verificFolder() {
    dire(Auxiliary.folderLog);
    //dire(Auxiliary.folderUser);
  }

  verificFile() {
    file(Auxiliary.alllog);
  }

  // Future getStatusPermission(Permissions permission) async {
  //   dynamic result = await SuperEasyPermissions.isGranted(permission);
  //   //= await SuperEasyPermissions.isGranted(permission);
  //   print(result);
  //   if (!result) {
  //     BuildContext context;

  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //     // while (result == false) {
  //     //   result = getPermission(permission).whenComplete(() {
  //     //     getStatusPermission(permission);
  //     //   });
  //     // }
  //   } else
  //     getDocuments();
  //   return result;
  // }

  // startVerific(Permissions permissions) async {
  //   dynamic result = await getStatusPermission(permissions);
  // }

  static Future getPermission(Permissions permissions) async {
    bool result = await SuperEasyPermissions.askPermission(permissions);
    print(result);
    return result;
  }

  dire(String direc) => _cDirectory(direc);
  file(String fil) => _cFile(fil);
  writing(var date, Object path) => _write(date, path);
  datetime() => _dateTime();
  //Le o usuario gravado no json
  reader(String path, String key) => _read(path, key);

  // TESTE

  // Future loadVault(Map content) async {
  //   String jsonString = await Auxiliary.loadAVaultAsset();
  //   final jsonResponse = json.decode(jsonString);
  //   var add = jsonResponse.toString();
  //   add = add.replaceFirst(new RegExp(r'}]'), "}," + content.toString() + "]");

  //   print(add);
  //   var value = JsonUtf8Encoder(add);
  // }
}
