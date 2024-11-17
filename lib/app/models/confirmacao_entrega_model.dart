class ConfirmacaoEntregaModel {
  num? idPedido;
  String? nomeResponsavel;
  String? rgResponsavel;
  String? cpfResponsavel;

  ConfirmacaoEntregaModel(
    this.idPedido,
    this.nomeResponsavel,
    this.rgResponsavel,
    this.cpfResponsavel,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPedido'] = idPedido ?? 0;
    data['nomeResponsavel'] = nomeResponsavel ?? '';
    data['rgResponsavel'] = rgResponsavel ?? '';
    data['cpfResponsavel'] = cpfResponsavel ?? '';
    return data;
  }
}
