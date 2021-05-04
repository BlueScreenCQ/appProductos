import 'dart:convert';

import 'package:form_validation/src/preferences/preferences.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyAWLhCuQm9JvfwP1HcQgn6SwEPlQub-gS4';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken');

    final resp = await http.post(
      url,
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey("idToken")) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp["idToken"]};
    }else{
      return { 'ok': false, 'mensaje': decodedResp["error"]["message"]};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario (String email, String password) async {

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken');

    final resp = await http.post(
      url,
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    //print(decodedResp);

    if(decodedResp.containsKey("idToken")) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp["idToken"]};
    }else{
      return { 'ok': false, 'mensaje': decodedResp["error"]["message"]};
    }
  }
}