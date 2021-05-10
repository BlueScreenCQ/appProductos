

import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/producto_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductoBloc {

  final _productoController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _prodcutoProvider = new ProductoProvider();

  Stream<List<ProductoModel>> get productosStream => _productoController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProductos() async {

    final productos = await _prodcutoProvider.cargarProductos();

    _productoController.sink.add(productos);
  }



  dispose() {
    _productoController?.close();
    _cargandoController?.close();
  }

}