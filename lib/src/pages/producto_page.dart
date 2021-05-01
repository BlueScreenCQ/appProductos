import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () {  }),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {  }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children:[
                _crearNombre(),
                _crearPrecio(),
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
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
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
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
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
      onPressed: _submit,
    );
  }

  void _submit() {

    if(!formKey.currentState.validate()) return;

    print('Todo ok');


  }
}

