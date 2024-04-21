abstract class EnderecoRoteiroEvent {}

class GetEnderecosRoteiro extends EnderecoRoteiroEvent {
  final int idRoteiro;

  GetEnderecosRoteiro({required this.idRoteiro});
}

class GetPedidos extends EnderecoRoteiroEvent {
  final String cep;
  final String numero;
  final int idRoteiro;

  GetPedidos({
    required this.cep,
    required this.numero,
    required this.idRoteiro,
  });
}

class AtualizarPosicao extends EnderecoRoteiroEvent {
  final int idRoteiro;
  final List enderecos;

  AtualizarPosicao({
    required this.idRoteiro,
    required this.enderecos,
  });
}

class EntregarPedido extends EnderecoRoteiroEvent {
  final int idRoteiro;
  final String cep;
  final String numero;
  final int idSituacao;
  final int idCliente;

  EntregarPedido({
    required this.idRoteiro,
    required this.cep,
    required this.numero,
    required this.idSituacao,
    required this.idCliente,
  });
}
