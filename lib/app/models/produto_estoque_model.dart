class ProdutoEstoqueModel {
  String? codigo;
  String? idTratamento;
  String? descricaoTratamento;
  String? descricao;
  String? idUnidade;
  String? linha;
  String? descricaoLinha;
  num? fornecedor;
  String? fantasiaFornecedor;
  num? estoque;
  num? pedido;
  num? encomenda;
  num? encomendaLivre;
  num? encomendaReservada;
  num? comprando;
  num? comprandoObra;
  num? tratandoNaoEnviado;
  num? tratando;
  num? tratandoOriginal;
  num? sucata;
  String? idGrupo;
  String? descricaoGrupo;
  String? setorEstoque;
  num? peso;
  num? pesoMedio;
  num? preco;
  num? custo;
  num? custoReal;
  num? baixoGiro;
  String? referencias;
  String? chave;
  num? expectativa;
  num? estoqueMinimo;
  String? fornecedorDisponivel;
  num? idTipoProduto;
  String? descricaoTipoProduto;
  num? idFabricante;
  String? descricaoFabricante;

  ProdutoEstoqueModel({
    this.codigo,
    this.idTratamento,
    this.descricaoTratamento,
    this.descricao,
    this.idUnidade,
    this.linha,
    this.descricaoLinha,
    this.fornecedor,
    this.fantasiaFornecedor,
    this.estoque,
    this.pedido,
    this.encomenda,
    this.encomendaLivre,
    this.encomendaReservada,
    this.comprando,
    this.comprandoObra,
    this.tratandoNaoEnviado,
    this.tratando,
    this.tratandoOriginal,
    this.sucata,
    this.idGrupo,
    this.descricaoGrupo,
    this.setorEstoque,
    this.peso,
    this.pesoMedio,
    this.preco,
    this.custo,
    this.custoReal,
    this.baixoGiro,
    this.referencias,
    this.chave,
    this.expectativa,
    this.estoqueMinimo,
    this.fornecedorDisponivel,
    this.idTipoProduto,
    this.descricaoTipoProduto,
    this.idFabricante,
    this.descricaoFabricante,
  });

  ProdutoEstoqueModel.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    idTratamento = json['idTratamento'];
    descricaoTratamento = json['descricaoTratamento'];
    descricao = json['descricao'];
    idUnidade = json['idUnidade'];
    linha = json['linha'];
    descricaoLinha = json['descricaoLinha'];
    fornecedor = json['fornecedor'];
    fantasiaFornecedor = json['fantasiaFornecedor'];
    estoque = json['estoque'];
    pedido = json['pedido'];
    encomenda = json['encomenda'];
    encomendaLivre = json['encomendaLivre'];
    encomendaReservada = json['encomendaReservada'];
    comprando = json['comprando'];
    comprandoObra = json['comprandoObra'];
    tratandoNaoEnviado = json['tratandoNaoEnviado'];
    tratando = json['tratando'];
    tratandoOriginal = json['tratandoOriginal'];
    sucata = json['sucata'];
    idGrupo = json['idGrupo'];
    descricaoGrupo = json['descricaoGrupo'];
    setorEstoque = json['setorEstoque'];
    peso = json['peso'];
    pesoMedio = json['pesoMedio'];
    preco = json['preco'];
    custo = json['custo'];
    custoReal = json['custoReal'];
    baixoGiro = json['baixoGiro'];
    referencias = json['referencias'];
    chave = json['chave'];
    expectativa = json['expectativa'];
    estoqueMinimo = json['estoqueMinimo'];
    fornecedorDisponivel = json['fornecedorDisponivel'];
    idTipoProduto = json['idTipoProduto'];
    descricaoTipoProduto = json['descricaoTipoProduto'];
    idFabricante = json['idFabricante'];
    descricaoFabricante = json['descricaoFabricante'];
  }
}
