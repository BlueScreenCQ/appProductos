import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
import 'package:form_validation/src/bloc/producto_bloc.dart';

export 'package:form_validation/src/bloc/login_bloc.dart';
export 'package:form_validation/src/bloc/producto_bloc.dart';


/// Este código crea un widget que hace la comunicación con todo el arbol de widgets del context
/// Lo vamos a poner como padre de la MaterialApp y todos los demás widgets que cuelgan de esta
/// van a poder hcer referencia al LoginBloc
class Provider extends InheritedWidget {

  final _loginBloc     = LoginBloc();
  final _productoBloc = ProductoBloc();

  //Se hace singleton para que no se pierda la info al hacer hot reload
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  //Cuando la información cambie se notifica a los hijos? si o no?
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  //Busca la instancia de LoginBloc en todo el arbol de widgets de context
  static LoginBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductoBloc productoBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productoBloc;
  }
}
