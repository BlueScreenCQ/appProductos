import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/preferences/preferences.dart';
import 'package:form_validation/src/providers/usuario_provider.dart';
import 'package:form_validation/src/services/facebook_signin_service.dart';
import 'package:form_validation/src/services/google_signin_service.dart';
import 'package:form_validation/src/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginForm extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [

          SafeArea(
            child: Container(
              height: size.height*0.3,
            ),
          ),

          Container(
            width: size.width*0.85,
            //margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 2.0
                )
              ]
            ),
            child: Column(
              children: [
                Text('Login', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 30.0,),
                _crearEmail(bloc),
                SizedBox(height: 30.0,),
                _crearPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc),
                //SignIn con Google
                SizedBox(height: 30.0,),
                _botonGoogle(context),
                //SignIn con Facebook
                SizedBox(height: 30.0,),
                _botonFacebook(context),
              ],
            ),
          ),

          SizedBox(height: 40.0,),
          ElevatedButton(
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text('Regístrate'),
            decoration: BoxDecoration(
            shape: BoxShape.rectangle
            ),
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, 'registro')
            ),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {

   return StreamBuilder(
     stream: bloc.emailStream,
     builder: (BuildContext context, AsyncSnapshot snapshot){
       return Container(
         padding: EdgeInsets.symmetric(horizontal: 20.0),
         child: TextField(
           keyboardType: TextInputType.emailAddress,
           decoration: InputDecoration(
             icon: Icon(Icons.alternate_email, color: Colors.lightBlue,),
             hintText: 'ejemplo@dominio.com',
             counterText: snapshot.data,
             errorText: snapshot.error,
           ),
           onChanged: bloc.changeEmail,
         ),
       );
     });
  }

  Widget _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Colors.lightBlue,),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        }
    );

  }

  Widget _crearBoton(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: Text('Acceder'),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle
            ),
          ),
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null
        );
      }
    );
  }

  Widget _botonGoogle(BuildContext context){

    return MaterialButton(
        splashColor: Colors.transparent,
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.google),
              Text('  Sign in with Google', style: TextStyle(color: Colors.white, fontSize: 17),)
            ],
          ),
        ),
      onPressed: () async {
        GoogleSignInAccount cuenta = await GoogleSingInServices.signInWithGoogle();

        if(cuenta != null){
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {

   Map info = await usuarioProvider.login(bloc.email, bloc.password);

   if(info['ok']){
     Navigator.pushReplacementNamed(context, 'home');
   }else{
     mostrarAlerta(context, "Los datos que ha introducido son incorrectos.");
   }
  }

  Widget _botonFacebook(BuildContext context) {

    return new botonFace();
  }
}


