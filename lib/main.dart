import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/pages/home_page.dart';
import 'package:form_validation/src/pages/login_page.dart';
import 'package:form_validation/src/pages/producto_page.dart';
import 'package:form_validation/src/pages/registro_page.dart';
import 'package:form_validation/src/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   FacebookAuth.instance.webInitialize(
  //     appId: "2984697485125118",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v9.0",
  //   );
  // }

  runApp(FormValidation());
}

class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation APP',
        initialRoute: 'login',
        routes: {
          'home'      : (_) => HomePage(),
          'registro'  : (_) => RegistroPage(),
          'login'    : (_) => LoginPage(),
          'producto' : (_) => ProductoPage(),
        },
      ),
    );
  }
}
