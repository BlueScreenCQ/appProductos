import 'package:flutter/material.dart';
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
