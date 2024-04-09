class ItemEnderecoRotaModel {
  num? id;
  num? volumeAcessorio;
  num? volumeChapa;
  num? volumePerfil;

  ItemEnderecoRotaModel({
    this.id,
    this.volumeAcessorio,
    this.volumeChapa,
    this.volumePerfil,
  });

  ItemEnderecoRotaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volumeAcessorio = json['volumeAcessorio'];
    volumeChapa = json['volumeChapa'];
    volumePerfil = json['volumePerfil'];
  }
}
