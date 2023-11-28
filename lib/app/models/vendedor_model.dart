class VendedorModel {
  int? id;
  String? nome;

  VendedorModel({
    id,
    nome,
  });

  VendedorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['fantasia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fantasia'] = nome;

    return data;
  }
}
