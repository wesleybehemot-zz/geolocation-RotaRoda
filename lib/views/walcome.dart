import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rotaroda/configs/AppFonts.dart';
import 'package:rotaroda/routes/app_routes.dart';
import 'package:rotaroda/source/Auxiliary.dart' as aux;
import 'package:url_launcher/url_launcher.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

dynamic f;
final snackBar = SnackBar(
  content: Text(
    'Necessaria Permissao!!\nMais informacoes consultar Politica de Privacidade',
    style: TextStyle(fontFamily: AppFonts.oswald),
  ),
  backgroundColor: Colors.black,
  duration: Duration(hours: 24),
  action: SnackBarAction(
    label: 'Aceitar',
    textColor: Colors.red,
    onPressed: () => aux.Suport.getPermission(Permissions.storage)
      ..then((value) {
        if (!value) {
          f = false;
        }
      }),
  ),
);

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
          children: [
            SizedBox(
              height: 110.0,
            ),
            Center(
              child: Text("Rota Roda",
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: AppFonts.oswald,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 220.0,
            ),
            Padding(
              padding: EdgeInsets.all(45),
              child: Center(
                child: TextButton(
                    onPressed: () async {
                      bool v =
                          await aux.Suport.getPermission(Permissions.storage);

                      if (!v) {
                        f = ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      } else {
                        await aux.Suport.getDocuments();
                        Navigator.of(context)
                            .popAndPushNamed(AppRoutes.Cadastro);
                      }

                      // if (f == false) {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //       content: Text(
                      //           'Voce foi impossibilitado\n de usar nossos servicos'),
                      //       action: SnackBarAction(
                      //         label: 'Quero usar!',
                      //         textColor: Colors.red,
                      //         onPressed: () =>
                      //             aux.Suport.getPermission(Permissions.storage),
                      //       )));
                      //}
                    },
                    child: Text('Cadastrar',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.oswald,
                        )),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black87))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Center(
                  child: InkWell(
                child: Text(
                  'Politica de Privacidade \n     SaturnCode 2021',
                ),
                onTap: () => launch(
                    'https://wooded-cobbler-ea7.notion.site/Pol-tica-de-privacidade-93bde79dbbc1415eb8600f8e838d46d4',
                    forceSafariVC: true,
                    forceWebView: false,
                    webOnlyWindowName: 'Chorme',
                    universalLinksOnly: true),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
