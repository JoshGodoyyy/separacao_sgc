class ProdutoModel {
  num? id;
  String? idProduto;
  String? descricao;
  String? idUnidade;
  num? quantidade;
  num? peso;
  num? pesoTotal;
  num? valorUnitario;
  num? precoCusto;
  num? ipiVenda;
  num? vOutros;
  num? valorTotal;
  String? idGrupo;
  num? valorGrupo;
  String? setorEstoque;
  String? observacoes;
  num? pesoRealTotalProduto;
  num? importacao;
  num? juros;
  num? difal;
  String? imagem;
  num? producaoPropria;
  String? chave;
  String? idTratamento;
  bool? separado;

  ProdutoModel({
    this.id,
    this.idProduto,
    this.descricao,
    this.idUnidade,
    this.quantidade,
    this.peso,
    this.pesoTotal,
    this.valorUnitario,
    this.precoCusto,
    this.ipiVenda,
    this.vOutros,
    this.valorTotal,
    this.idGrupo,
    this.valorGrupo,
    this.setorEstoque,
    this.observacoes,
    this.pesoRealTotalProduto,
    this.importacao,
    this.juros,
    this.difal,
    this.imagem,
    this.producaoPropria,
    this.chave,
    this.idTratamento,
    this.separado,
  });

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduto = json['idProduto'];
    descricao = json['descricao'];
    idUnidade = json['idUnidade'];
    quantidade = json['quantidade'];
    peso = json['peso'];
    pesoTotal = json['pesoTotal'];
    valorUnitario = json['valorUnitario'];
    precoCusto = json['precoCusto'];
    ipiVenda = json['ipiVenda'];
    vOutros = json['vOutros'];
    valorTotal = json['valorTotal'];
    idGrupo = json['idGrupo'];
    valorGrupo = json['valorGrupo'];
    setorEstoque = json['setorEstoque'];
    observacoes = json['observacoes'];
    pesoRealTotalProduto = json['pesoRealTotalProduto'];
    importacao = json['importacao'];
    juros = json['juros'];
    difal = json['difal'];
    imagem = json['imagem'] ?? '';
    producaoPropria = json['producaoPropria'];
    chave = json['chave'];
    idTratamento = json['idTratamento'];
    separado = json['separado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idProduto'] = idProduto;
    data['descricao'] = descricao;
    data['idUnidade'] = idUnidade;
    data['quantidade'] = quantidade;
    data['peso'] = peso;
    data['pesoTotal'] = pesoTotal;
    data['valorUnitario'] = valorUnitario;
    data['precoCusto'] = precoCusto;
    data['ipiVenda'] = ipiVenda;
    data['vOutros'] = vOutros;
    data['valorTotal'] = valorTotal;
    data['idGrupo'] = idGrupo;
    data['valorGrupo'] = valorGrupo;
    data['setorEstoque'] = setorEstoque;
    data['observacoes'] = observacoes;
    data['pesoRealTotalProduto'] = pesoRealTotalProduto;
    data['importacao'] = importacao;
    data['juros'] = juros;
    data['difal'] = difal;
    data['imagem'] = imagem;
    data['producaoPropria'] = producaoPropria;
    data['chave'] = chave;
    data['idTratamento'] = idTratamento;
    data['separado'] = separado;
    return data;
  }
}
