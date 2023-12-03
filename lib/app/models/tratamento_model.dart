class TratamentoModel {
  String? id;
  String? descricao;

  TratamentoModel(
    id,
    descricao,
  );

  TratamentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }
}
