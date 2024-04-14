abstract class PedidoRoteiroEvent {}

class GetPedido extends PedidoRoteiroEvent {
  final int idPedido;

  GetPedido({required this.idPedido});
}
