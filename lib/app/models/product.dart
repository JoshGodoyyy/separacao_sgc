import 'package:sgc/app/models/colors.dart';

class Product {
  final String tipo;
  final String codigo;
  final String descricao;
  final String unidade;
  final double quantidade;
  final double pesoUnit;
  final Cor cor;
  final String? observacoes;

  Product(
    this.tipo,
    this.codigo,
    this.descricao,
    this.unidade,
    this.quantidade,
    this.pesoUnit,
    this.cor,
    this.observacoes,
  );
}
