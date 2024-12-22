abstract class PedidoEvent {}

class GetPedidosSituacao extends PedidoEvent {
  final int idSituacao;
  final int tipoProduto;

  GetPedidosSituacao({
    required this.idSituacao,
    required this.tipoProduto,
  });
}

class SearchPedido extends PedidoEvent {
  final int idSituacao;
  final int idPedido;
  final int tipoProduto;

  SearchPedido({
    required this.idSituacao,
    required this.idPedido,
    required this.tipoProduto,
  });
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

class FinalizarSeparacao extends PedidoEvent {
  final int idSituacao;
  final String observacoesSeparacao;
  final int volumePerfil;
  final int volumeAcessorio;
  final int volumeChapa;
  final double pesoTotalTeorico;
  final double pesoTotalReal;
  final double valorTotalTeorico;
  final double valorTotalReal;
  final int sepAcessorio;
  final int sepPerfil;
  final int idSeparador;
  final String chaveLiberacao;
  final int id;

  FinalizarSeparacao({
    required this.idSituacao,
    required this.observacoesSeparacao,
    required this.volumePerfil,
    required this.volumeAcessorio,
    required this.volumeChapa,
    required this.pesoTotalTeorico,
    required this.pesoTotalReal,
    required this.valorTotalTeorico,
    required this.valorTotalReal,
    required this.sepAcessorio,
    required this.sepPerfil,
    required this.idSeparador,
    required this.chaveLiberacao,
    required this.id,
  });
}
