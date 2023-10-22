import 'package:flutter/material.dart';
import 'package:sgc/app/models/vendedor_model.dart';

import '/app/models/cliente_model.dart';
import '/app/models/pedido_model.dart';

class Pedidos {
  static List<Pedido> pedidosSeparar = [
    Pedido(
      Icons.account_tree_rounded,
      2491,
      'Pedido',
      'Venda',
      VendedorModel(
        1,
        'Matheus',
      ),
      DateTime(2023, 10, 10, 12, 35),
      1,
      'Sastec',
      'Separar',
      ClienteModel(
        24,
        'Andreozi',
        'Company Comercio de Vidros LTDA',
        '13348-670',
        'Avenida Engenheiro Fábio Roberto Barnabe',
        4764,
        'Casa',
        'Jardim Colonial',
        'Indaiatuba',
        'SP',
      ),
      DateTime(2023, 10, 1, 12, 35),
      'Retira',
      0,
      0,
    ),
  ];
  static List<Pedido> pedidosSeparando = [];
  static List<Pedido> pedidosEmbalagem = [];
  static List<Pedido> pedidosConferencia = [];
  static List<Pedido> pedidosFaturar = [];
  static List<Pedido> pedidosLogistica = [];
}
