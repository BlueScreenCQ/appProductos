

import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
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
  Future<bool> editarProducto(ProductoModel producto) async {
    final url = Uri.https(_url, '/productos/${producto.id}.json');

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    //print(decodedData);

    return true;
  }



  Future<List<ProductoModel>> cargarProductos() async {

    final url = Uri.https(_url, '/productos.json');

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = [];

    print(decodedData);

    if(decodedData == null) return [];

    //TODO si el token viene expirado. Podemos devolver al login
    if(decodedData['error'] !=null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id= id;
      productos.add(prodTemp);
    });

    //print(productos);
    return productos;
  }

  Future<bool> borrarProducto(String id) async {

    final url = Uri.https(_url, '/productos/$id.json');

    final resp = await http.delete(url);

    //print (resp.body);

    return true;
  }

  Future<String> subirImagen (File image) async {

    // Client id     : 0c29c8d588b2327
    // Client secret : 3f8b8538cf98498020e5400cecdf714d73e21072

    var headers = {
      'Authorization': 'Client-ID 0c29c8d588b2327'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://api.imgur.com/3/image'));
    request.fields.addAll({
      'image': image.path,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      final data = await response.stream.bytesToString();
      final decodedData = json.decode(data);
      print(decodedData.data["link"]);
    }
    else {
      print("Error al subir la imagen a imgur: ${response.reasonPhrase}");
    }
  }

  // Future<String> subirImagen (File image) async {
  //
  //   final url = Uri.parse(''); //url de endpoint para subir la imagen
  //   final mimeType = mime(image.path).split('/'); //image/jpeg
  //
  //   final imageUploadRequest = http.MultipartRequest(
  //     'POST',
  //     url,
  //   );
  //
  //   final file = await http.MultipartFile.fromPath(
  //     'file',
  //     image.path,
  //     contentType: MediaType(mimeType[0], mimeType[1]),
  //   );
  //
  //   imageUploadRequest.files.add(file);
  //
  //   final streamResponse = await imageUploadRequest.send();
  //
  //   final resp = await http.Response.fromStream(streamResponse);
  //
  //   if ( resp.statusCode != 200 && resp.statusCode != 201) {
  //     print('Error al subir la imágen');
  //     print(resp.body);
  //     return null;
  //   }
  //
  //   final responseData = json.decode(resp.body);
  //   print(responseData);
  //
  //   return responseData['secure_url'];
  // }
}