import 'package:flutter/material.dart';

class Product {
  final String tipo;
  final String codigo;
  final String descricao;
  final String unidade;
  final double quantidade;
  final double pesoUnit;
  final Color cor;

  Product(
    this.tipo,
    this.codigo,
    this.descricao,
    this.unidade,
    this.quantidade,
    this.pesoUnit,
    this.cor,
  );
}
