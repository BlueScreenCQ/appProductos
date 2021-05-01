import 'package:flutter/material.dart';
import 'package:form_validation/src/widgets/fondo.dart';
import 'package:form_validation/src/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          LoginForm(),

        ],
      ),
    );
  }
}