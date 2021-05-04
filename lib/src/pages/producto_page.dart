import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/producto_provider.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';


class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductoModel producto = new ProductoModel();
  final productoProvider = new ProductoProvider();
  bool _guardando = false;
  File foto;


  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
      producto = prodData;
    }

    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarImagen),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _hacerFoto),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children:[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                SizedBox(height:20.0),
                _cearBoton(),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo=value,
      validator: (value) {
        if(value.length < 3 ){
          return 'Nombre demasiado corto';
        }
        else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      // initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.valor= double.parse(value),
      validator: (value) {
        if (utils.esNumero (value)) return null;
        else return 'Sólo números';
      },
    );
  }

  Widget _cearBoton(){
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Colors.lightBlue
      ),
      icon: Icon(Icons.save, color: Colors.white,),
      label: Text('Guardar', style: TextStyle(color: Colors.white,),),
      onPressed: (_guardando) ? null : _submit,
    );
  }

 Widget _crearDisponible() {

    return SwitchListTile(
        value: producto.disponible,
        title: Text('Disponible'),
        onChanged: (value) => setState(() {
          producto.disponible = value;
        })
    );
 }

  void _submit() async {

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto!= null){
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }

    if(producto.id == null ) {
      productoProvider.crearProducto(producto);
      _mostrarSnackBar("El producto ha sido creado con éxito");
    }
    else{
      productoProvider.editarProducto(producto);
      _mostrarSnackBar("El producto ha sido editado con éxito");
    }

    setState(() {
      _guardando = false;
    });

    Navigator.pop(context);
  }

  void _mostrarSnackBar(String mensaje){

    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    //Deprecated
    //scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset(foto?.path ?? 'assets/no-image.png');
    }
  }

  _seleccionarImagen() async {
    _procesarImagen(ImageSource.gallery);
  }

  _hacerFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();
    final pickedFile =
    await _picker.getImage(source: origen, maxHeight: 720, maxWidth: 720);
    foto = File(pickedFile.path);
    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});
  }

  // Widget _mostrarFoto() {
  //
  //   if(producto.fotoUrl != null ) {
  //     return Container(
  //       // TODO HAY QUE PONER LA FOTO
  //     );
  //   }else{
  //     return Image(
  //       image: AssetImage( foto?.path ?? 'assets/no-image.png' ),
  //       height: 300.0,
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
  //
  //
  // _seleccionarImagen() async {
  //   final _picker = ImagePicker();
  //
  //   final pickedFile = await _picker.getImage(
  //     source: ImageSource.gallery,
  //   );
  //
  //   foto = File(pickedFile.path);
  //
  //   if (foto != null) {
  //     producto.fotoUrl = null;
  //   }
  //   setState(() {});
  // }
  //
  // _hacerFoto() {
  //
  //
  // }

}

