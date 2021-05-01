import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:form_validation/src/bloc/validators.dart';

class LoginBloc with Validators { //Mezclamos el loginbloc con el validator para tener en la misma clase las propiedades de los dos

  // final _emailController = new StreamController<String>.broadcast();
  // final _passwordController = new StreamController<String>.broadcast();
  // Es lo mismo, viene con el broadcast por defecto
  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);


  // Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor de los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;


  dispose(){
    _emailController?.close();  // ?: si existe me lo cargo
    _passwordController?.close();
  }
}

// //era
// tream<bool> get formValidStream =>
//     Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );
// //ahora es
// Stream<bool> get formValidStream =>
//     Rx.combineLatest2(emailStream, passwStream, (e, p) => true);