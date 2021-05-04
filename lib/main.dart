import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/pages/home_page.dart';
import 'package:form_validation/src/pages/login_page.dart';
import 'package:form_validation/src/pages/producto_page.dart';

void main() => runApp(FormValidation());

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
          'login'    : (_) => LoginPage(),
          'producto' : (_) => ProductoPage(),
        },
      ),
    );
  }
}
