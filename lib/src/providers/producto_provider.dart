

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:form_validation/src/models/producto_model.dart';

class ProductoProvider {

  final String _url = 'fluttercurso-311817-default-rtdb.europe-west1.firebasedatabase.app';


  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.https(_url, '/productos.json');

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    //print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {

    final url = Uri.https(_url, '/productos.json');

    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = [];

    print(decodedData);

    if(decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id= id;
      productos.add(prodTemp);
    });

    //print(productos);
    return productos;
  }

}