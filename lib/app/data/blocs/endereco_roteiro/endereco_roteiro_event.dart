import 'package:sgc/app/models/endereco_roteiro_entrega_model.dart';

abstract class EnderecoRoteiroEvent {}

class GetEnderecosRoteiro extends EnderecoRoteiroEvent {
  final int idRoteiro;

  GetEnderecosRoteiro({required this.idRoteiro});
}

class EntregarPedido extends EnderecoRoteiroEvent {
  final EnderecoRoteiroEntregaModel pedido;

  EntregarPedido({required this.pedido});
}
