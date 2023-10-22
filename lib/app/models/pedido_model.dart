import 'package:flutter/material.dart';
import 'package:sgc/app/models/product.dart';

import '../models/cliente_model.dart';
import '../models/vendedor_model.dart';
import 'pack.dart';

class Pedido {
  final IconData icone;
  final int idPedido;
  final String tipo;
  final String tipoVenda;
  final VendedorModel vendedor;
  final DateTime dataCriacao;
  final int idUsuario;
  final String nomeUsuario;
  final String statusPedido;
  final ClienteModel cliente;
  final DateTime dataHoraEntrega;
  final String tipoEntrega;
  final int nfeVenda;
  final int nfeRemessa;
  final List<Product> produtos;
  final List<Pack> embalagens;

  Pedido(
    this.icone,
    this.idPedido,
    this.tipo,
    this.tipoVenda,
    this.vendedor,
    this.dataCriacao,
    this.idUsuario,
    this.nomeUsuario,
    this.statusPedido,
    this.cliente,
    this.dataHoraEntrega,
    this.tipoEntrega,
    this.nfeVenda,
    this.nfeRemessa,
    this.produtos,
    this.embalagens,
  );
}
