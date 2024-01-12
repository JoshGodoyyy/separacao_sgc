import '../../../models/pedido_model.dart';

abstract class PedidoEvent {}

class GetPedidosSituacao extends PedidoEvent {
  final int idSituacao;

  GetPedidosSituacao({required this.idSituacao});
}

class SearchPedido extends PedidoEvent {
  final int idSituacao;
  final int idPedido;

  SearchPedido({required this.idSituacao, required this.idPedido});
}

class UpdatePedido extends PedidoEvent {
  final double volAcessorio;
  final double volAlum;
  final double volChapa;
  final String obsSeparacao;
  final String obsSeparador;
  final String setorEstoque;
  final double pesoAcessorio;
  final int idPedido;

  UpdatePedido({
    required this.volAcessorio,
    required this.volAlum,
    required this.volChapa,
    required this.obsSeparacao,
    required this.obsSeparador,
    required this.setorEstoque,
    required this.pesoAcessorio,
    required this.idPedido,
  });
}

class DeletePedido extends PedidoEvent {
  final PedidoModel pedido;

  DeletePedido({required this.pedido});
}
