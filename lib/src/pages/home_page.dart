import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/producto_provider.dart';

class HomePage extends StatelessWidget {

  final productoProvider = ProductoProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: productoProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){

          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },

    );
  }

  Widget _crearItem(BuildContext context, ProductoModel prod){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        productoProvider.borrarProducto(prod.id);
      },
      child: Card(
        child: Column(
          children: [
            (prod.fotoUrl == null)
            ? Image(image: AssetImage('assets/no-image.png'))
            : FadeInImage(
              image: NetworkImage(prod.fotoUrl),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
              ListTile(
                title: Text('${prod.titulo} - ${prod.valor}'),
                subtitle: Text(prod.id),
                onTap: () => Navigator.pushNamed(context, 'producto', arguments: prod ),
              ),
          ],
        ),
      )
    );
  }
}
