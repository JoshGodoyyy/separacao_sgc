import '../../../models/foto_pedido_model.dart';

abstract class FotoPedidoEvent {}

class GetFotos extends FotoPedidoEvent {
  final FotoPedidoModel fotoPedido;
  GetFotos({
    required this.fotoPedido,
  });
}

class PostFoto extends FotoPedidoEvent {
  final FotoPedidoModel foto;
  PostFoto({required this.foto});
}

class UpdateFoto extends FotoPedidoEvent {
  final int id;
  final FotoPedidoModel foto;
  UpdateFoto({
    required this.id,
    required this.foto,
  });
}

class DeleteFoto extends FotoPedidoEvent {
  final FotoPedidoModel foto;
  DeleteFoto({required this.foto});
}
