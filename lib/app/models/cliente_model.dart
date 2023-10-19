class ClienteModel {
  final int id;
  final String fantasia;
  final String razaoSocial;
  final int idVendedor;
  final String vendedor;
  final String cep;
  final String endereco;
  final int numero;
  final String? complemento;
  final String bairro;
  final String cidade;
  final String uf;

  ClienteModel(
    this.id,
    this.fantasia,
    this.razaoSocial,
    this.idVendedor,
    this.vendedor,
    this.cep,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
  );
}
