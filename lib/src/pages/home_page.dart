import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/producto_provider.dart';
import 'package:form_validation/src/services/google_signin_service.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productoProvider = ProductoProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.doorOpen),
            onPressed: () {
              GoogleSingInServices.signOut();
              Navigator.pushReplacementNamed(context, 'login');
            })
        ],
        ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'producto').then((value) { setState(() { });})
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
                title: Text('${prod.titulo} - ${prod.valor} €'),
                subtitle: Text(prod.id),
                trailing: (prod.disponible) ? Icon(Icons.check, color: Colors.green) : Icon(Icons.cancel, color: Colors.red),
                onTap: () => Navigator.pushNamed(context, 'producto', arguments: prod ).then((value) { setState(() { }); }),
              ),
          ],
        ),
      )
    );
  }
}
