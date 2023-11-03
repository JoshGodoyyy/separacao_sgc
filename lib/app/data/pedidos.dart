import 'package:flutter/material.dart';
import 'package:sgc/app/models/colors.dart';
import 'package:sgc/app/models/product.dart';
import 'package:sgc/app/models/tratamento.dart';
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
      Tratamento(
        'NAT',
        'NATURAL',
      ),
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
      [
        Product(
          'Perfil',
          'ALG-1001CHA',
          'Perfil Natural 6000mm',
          'PC',
          100,
          3,
          Cor(
            'Laranja',
            Colors.orange,
          ),
          null,
        ),
        Product(
          'Perfil',
          'ALG-1038CHA',
          'Perfil Branco 6000mm',
          'KG',
          200,
          6,
          Cor(
            'Amarelo',
            Colors.yellow,
          ),
          null,
        ),
        Product(
          'Perfil',
          'ALG-1038C',
          'Perfil Branco 6000mm',
          'KG',
          500,
          6,
          Cor(
            'Verde',
            Colors.green,
          ),
          null,
        ),
        Product(
          'Acessório',
          '+PAB42X16IN',
          'Parafuso 4,2X16mm Cabeça Chata PHS Brocante Inox',
          'PC',
          50,
          0,
          Cor(
            'Vermelho',
            Colors.red,
          ),
          null,
        ),
        Product(
          'Acessório',
          '+PC42X16IN',
          'Parafuso 4,2X16mm Cabeça Chata PHS',
          'PC',
          50,
          0,
          Cor(
            'Azul',
            Colors.blue,
          ),
          null,
        ),
      ],
      [],
    ),
  ];
  static List<Pedido> pedidosSeparando = [];
  static List<Pedido> pedidosEmbalagem = [];
  static List<Pedido> pedidosConferencia = [];
  static List<Pedido> pedidosFaturar = [];
  static List<Pedido> pedidosLogistica = [];
}
