import 'package:flutter/material.dart';

class Fondo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    final fondoMorado = Container(
      height: size.height*0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(60, 132, 235, 1.0),
            Color.fromRGBO(40, 123, 225, 1.0),
          ]
        )
      ),
    );

    final circulo = new Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    final logo = new SafeArea(
      bottom: false,
      child: Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            //Esto y lo de infinity tiene el mismo efecto
            //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
                SizedBox(height: 10.0, width: double.infinity),
                Text('Fran Castro', style: TextStyle(color: Colors.white, fontSize: 28),)
              ]
          )
      ),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -20.0, right: -10.0, child: circulo),
        Positioned(bottom: -20.0, right: -10.0, child: circulo),
        Positioned(top: 150.0, right: 100.0, child: circulo),
        logo
      ],
    );

  }
}
