import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';

 class botonFace extends StatefulWidget {
   @override
   _botonFaceState createState() => _botonFaceState();
 }

 class _botonFaceState extends State<botonFace> {
   @override
   Widget build(BuildContext context) {

     bool _isLoggedIn = false;
     Map _userObj = {};

     return  Container(
       child: _isLoggedIn
           ? Column(
         children: [
           Image.network(_userObj["picture"]["data"]["url"]),
           Text(_userObj["name"]),
           Text(_userObj["email"]),
           TextButton(
               onPressed: () {
                 FacebookAuth.instance.logOut().then((value) {
                   setState(() {
                     _isLoggedIn = false;
                     _userObj = {};
                   });
                 });
               },
               child: Text("Logout"))
         ],
       )
           : Center(
         child: ElevatedButton(
           child: Text("Login with Facebook"),
           onPressed: () async {
             FacebookAuth.instance.login(
                 permissions: ["public_profile", "email"]).then((value) {
               FacebookAuth.instance.getUserData().then((userData) {
                 setState(() {
                   _isLoggedIn = true;
                   _userObj = userData;
                 });
               });
             });
           },
         ),
       ),
     );
   }
 }
