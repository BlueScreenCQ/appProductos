import 'package:flutter/material.dart';
import 'package:form_validation/src/providers/usuario_provider.dart';
import 'package:form_validation/src/widgets/fondo.dart';
import 'package:form_validation/src/widgets/registro_form.dart';

class RegistroPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          RegistroForm(),

        ],
      ),
    );
  }
}