import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/preferences/preferences.dart';
import 'package:form_validation/src/providers/producto_provider.dart';
import 'package:form_validation/src/services/google_signin_service.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.productoBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(_prefs.googleToken[2]),
            ),
            onPressed: () => utils.mostrarInfoCuenta(context, _prefs.googleToken),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.doorOpen),
            onPressed: () {
              GoogleSingInServices.signOut();
              Navigator.pushReplacementNamed(context, 'login');
            })
        ],
        ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'producto').then((value) { setState(() { });})
    );
  }

  Widget _crearListado(ProductoBloc productosBloc) {

    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productosBloc, productos[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _crearItem(BuildContext context, ProductoBloc productoBloc, ProductoModel prod){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => productoBloc.borrarProducto(prod.id),
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
