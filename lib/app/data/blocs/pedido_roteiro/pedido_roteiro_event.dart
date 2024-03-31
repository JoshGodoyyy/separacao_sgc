import 'package:sgc/app/models/pedido_roteiro_model.dart';

abstract class PedidoRoteiroEvent {}

class GetPedidosNaoCarregados extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;

  GetPedidosNaoCarregados({required this.pedido});
}

class GetPedidosCarregados extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;

  GetPedidosCarregados({required this.pedido});
}

class CarregarPedido extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;

  CarregarPedido({required this.pedido});
}

class DescarregarPedido extends PedidoRoteiroEvent {
  final PedidoRoteiroModel pedido;

  DescarregarPedido({required this.pedido});
}
