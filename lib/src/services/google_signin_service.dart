import 'package:form_validation/src/preferences/preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInServices {

  static final _prefs = PreferenciasUsuario();

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount> signInWithGoogle() async {

    try{
      final GoogleSignInAccount acount =  await _googleSignIn.signIn();
      final googleKey = await acount.authentication;

      print(acount);
      print('========idToken=========');
      print(googleKey.idToken);

      //Guardamos los tokens en las preferencias
      List<String> _googlePrefs = [];
      _googlePrefs.add(acount.email);
      _googlePrefs.add(acount.displayName);
      _googlePrefs.add(acount.photoUrl);
      _prefs.googleToken = _googlePrefs;

      // TODO Lamar a un servicio REST con el IdToken para autenticar en el backend

      return acount;

    }catch(e){
      print('Error en Google SignIn');
      print(e);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
    _prefs.googleToken = null;
  }

}