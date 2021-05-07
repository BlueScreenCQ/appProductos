

import 'package:flutter/material.dart';

bool esNumero(String s) {

    if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null ) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Datos incorrectos'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok')
          )
        ],
      );
    }
  );
}

void mostrarInfoCuenta(BuildContext context, List<String> prefs) {

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cuenta de Google', textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(prefs[2]),
                ),
              Text(prefs[1], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(prefs[0], style: TextStyle(fontSize: 15),),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok')
            )
          ],
        );
      }
  );
}