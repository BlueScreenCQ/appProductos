

import 'dart:io';

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

  void agregarProducto( ProductoModel producto ) async {
    
    _cargandoController.sink.add(true);
    await _prodcutoProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoURL = await _prodcutoProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoURL;
  }

  void editarProducto( ProductoModel producto ) async {

    _cargandoController.sink.add(true);
    await _prodcutoProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto( String id ) async {

    await _prodcutoProvider.borrarProducto(id);
  }



  dispose() {
    _productoController?.close();
    _cargandoController?.close();
  }

}