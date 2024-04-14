import 'package:sgc/app/models/pedido_roteiro_model.dart';

abstract class PedidoRoteiroEvent {}

class GetPedidosNaoCarregados extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;
  final bool separarAgrupamento;

  GetPedidosNaoCarregados({
    required this.pedido,
    required this.separarAgrupamento,
  });
}

class GetPedidosCarregados extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;
  final bool separarAgrupamento;

  GetPedidosCarregados({
    required this.pedido,
    required this.separarAgrupamento,
  });
}

class CarregarPedido extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;
  final bool separarAgrupamento;

  CarregarPedido({
    required this.pedido,
    required this.separarAgrupamento,
  });
}

class DescarregarPedido extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;
  final bool separarAgrupamento;

  DescarregarPedido({
    required this.pedido,
    required this.separarAgrupamento,
  });
}
