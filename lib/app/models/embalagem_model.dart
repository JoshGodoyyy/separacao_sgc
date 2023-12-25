class EmbalagemModel {
  num? id;
  num? idPedido;
  String? idCaixa;
  num? quantidadeCaixa;
  num? pesoCaixa;
  String? observacoes;

  EmbalagemModel({
    this.id,
    this.idPedido,
    this.idCaixa,
    this.quantidadeCaixa,
    this.pesoCaixa,
    this.observacoes,
  });

  EmbalagemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPedido = json['idPedido'];
    idCaixa = json['idCaixa'];
    quantidadeCaixa = json['quantidadeCaixa'];
    pesoCaixa = json['pesoCaixa'];
    observacoes = json['observacoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idPedido'] = idPedido;
    data['idCaixa'] = idCaixa;
    data['quantidadeCaixa'] = quantidadeCaixa;
    data['pesoCaixa'] = pesoCaixa;
    data['observacoes'] = observacoes;
    return data;
  }
}
