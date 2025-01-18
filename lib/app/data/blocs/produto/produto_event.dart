abstract class ProdutoEvent {}

class GetProdutos extends ProdutoEvent {
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  GetProdutos({
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
    required this.idPedido,
  });
}

class UpdateSeparacao extends ProdutoEvent {
  final int? idUsuarioSeparador;
  final int idProduto;
  final int separado;
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  UpdateSeparacao({
    required this.idUsuarioSeparador,
    required this.idProduto,
    required this.separado,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
    required this.idPedido,
  });
}

class UpdateEmbalagem extends ProdutoEvent {
  final int idProduto;
  final int embalado;
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  UpdateEmbalagem({
    required this.idProduto,
    required this.embalado,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
    required this.idPedido,
  });
}

class UpdateConferencia extends ProdutoEvent {
  final int idProduto;
  final int conferido;
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  UpdateConferencia({
    required this.idProduto,
    required this.conferido,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
    required this.idPedido,
  });
}
