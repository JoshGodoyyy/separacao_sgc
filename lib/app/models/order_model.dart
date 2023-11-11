import 'package:flutter/material.dart';

import 'client_model.dart';
import 'group_model.dart';
import 'product.dart';
import 'vendedor_model.dart';
import 'pack.dart';
import 'tratamento.dart';

class Pedido {
  final IconData icone;
  final int idPedido;
  final String tipo;
  final String tipoVenda;
  final Tratamento tratamento;
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
  final List<GroupModel> grupos;

  Pedido(
    this.icone,
    this.idPedido,
    this.tipo,
    this.tipoVenda,
    this.tratamento,
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
    this.grupos,
  );
}
