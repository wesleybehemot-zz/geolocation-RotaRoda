import 'package:permission_handler/permission_handler.dart';
import 'package:rotaroda/backend/Auxiliary.dart';

class Push {
  // Auxiliary axi = Auxiliary();
  // Person person = Person();
  Suport sup = Suport();

  Push() {
    sup.getPermissionSatus(Permission.storage);
  }
  push() async {
   
    
  }
}
