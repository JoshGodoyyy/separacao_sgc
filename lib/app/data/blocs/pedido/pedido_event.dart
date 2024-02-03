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

class EnviarSeparacao extends PedidoEvent {
  final int idSituacao;
  final String dataLiberacaoSeparacao;
  final String dataEnvioSeparacao;
  final String idIniciarSeparacao;
  final int sepAcessorio;
  final int sepPerfil;
  final int id;

  EnviarSeparacao({
    required this.idSituacao,
    required this.dataLiberacaoSeparacao,
    required this.dataEnvioSeparacao,
    required this.idIniciarSeparacao,
    required this.sepAcessorio,
    required this.sepPerfil,
    required this.id,
  });
}

class EnviarEmbalagem extends PedidoEvent {
  final int idSituacao;
  final String observacoesSeparacao;
  final int idSeparador;
  final String dataRetornoSeparacao;
  final String idConcluirSeparacao;
  final int sepAcessorio;
  final int sepPerfil;
  final int id;
  final int tipoProduto;

  EnviarEmbalagem({
    required this.idSituacao,
    required this.observacoesSeparacao,
    required this.idSeparador,
    required this.dataRetornoSeparacao,
    required this.idConcluirSeparacao,
    required this.sepAcessorio,
    required this.sepPerfil,
    required this.id,
    required this.tipoProduto,
  });
}

class LiberarConferencia extends PedidoEvent {
  final int idSituacao;
  final String observacoesSeparacao;
  final int id;

  LiberarConferencia({
    required this.idSituacao,
    required this.observacoesSeparacao,
    required this.id,
  });
}
