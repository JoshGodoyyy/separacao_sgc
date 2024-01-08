class GrupoModel {
  num? id;
  String? idGrupo;
  String? descricao;
  num? pesoTeorico;
  num? pesoReal;
  num? valorGrupo;
  num? valorReal;
  num? separado;
  num? juros;
  num? difal;

  GrupoModel({
    this.id,
    this.idGrupo,
    this.descricao,
    this.pesoTeorico,
    this.pesoReal,
    this.valorGrupo,
    this.valorReal,
    this.separado,
    this.juros,
    this.difal,
  });

  GrupoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGrupo = json['idGrupo'];
    descricao = json['descricao'];
    pesoTeorico = json['pesoTeorico'];
    pesoReal = json['pesoReal'];
    valorGrupo = json['valorGrupo'];
    valorReal = json['valorReal'];
    separado = json['separado'];
    juros = json['juros'];
    difal = json['difal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idGrupo'] = idGrupo;
    data['descricao'] = descricao;
    data['pesoTeorico'] = pesoTeorico;
    data['pesoReal'] = pesoReal;
    data['valorGrupo'] = valorGrupo;
    data['valorReal'] = valorReal;
    data['separado'] = separado;
    data['juros'] = juros;
    data['difal'] = difal;
    return data;
  }
}
