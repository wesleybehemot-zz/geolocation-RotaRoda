import 'package:rotaroda/backend/Auxiliary.dart' as sup;
import 'package:super_easy_permissions/super_easy_permissions.dart';

class Push {
  static initialProject() {
    sup.Suport().startVerific(Permissions.storage);
  }
}
