import 'package:flutter/material.dart';

import '../models/cliente_model.dart';

class Pedido {
  final IconData icone;
  final int idPedido;
  final String tipo;
  final String tipoVenda;
  final DateTime dataCriacao;
  final int idUsuario;
  final String nomeUsuario;
  final String statusPedido;
  final ClienteModel cliente;
  final DateTime dataHoraEntrega;
  final String tipoEntrega;
  final int nfeVenda;
  final int nfeRemessa;

  Pedido(
    this.icone,
    this.idPedido,
    this.tipo,
    this.tipoVenda,
    this.dataCriacao,
    this.idUsuario,
    this.nomeUsuario,
    this.statusPedido,
    this.cliente,
    this.dataHoraEntrega,
    this.tipoEntrega,
    this.nfeVenda,
    this.nfeRemessa,
  );
}
