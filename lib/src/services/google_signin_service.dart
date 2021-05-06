import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInServices {

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
  }

}