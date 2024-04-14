abstract class PedidoRoteiroEvent {}

class GetPedidosNaoCarregados extends PedidoRoteiroEvent {
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;
  final bool separarAgrupamento;

  GetPedidosNaoCarregados({
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
    required this.separarAgrupamento,
  });
}

class GetPedidosCarregados extends PedidoRoteiroEvent {
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;
  final bool separarAgrupamento;

  GetPedidosCarregados({
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
    required this.separarAgrupamento,
  });
}

class CarregarPedido extends PedidoRoteiroEvent {
  final int idPedido;
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;
  final bool separarAgrupamento;

  CarregarPedido({
    required this.idPedido,
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
    required this.separarAgrupamento,
  });
}

class DescarregarPedido extends PedidoRoteiroEvent {
  final int idPedido;
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;
  final bool separarAgrupamento;

  DescarregarPedido({
    required this.idPedido,
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
    required this.separarAgrupamento,
  });
}
