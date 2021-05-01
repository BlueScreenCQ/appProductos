// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.id,
    this.titulo,
    this.valor,
    this.disponible,
    this.fotoUrl,
  });

  String id;
  String titulo = '';
  double valor = 0.0;
  bool disponible = true;
  String fotoUrl;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
    id: json["id"],
    titulo: json["titulo"],
    valor: json["valor"],
    disponible: json["disponible"],
    fotoUrl: json["fotoURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "valor": valor,
    "disponible": disponible,
    "fotoURL": fotoUrl,
  };
}