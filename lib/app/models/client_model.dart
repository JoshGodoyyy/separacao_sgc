class ClienteModel {
  num? id;
  String? fantasia;
  String? razaoSocial;
  num? posicao;
  num? quantidadePedidos;
  num? pedidosAgrupados;
  String? idPedidosAgrupados;
  num? pedidosCarregados;
  num? idCliente;
  num? idSituacao;
  String? logradouro;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  num? volumeAcessorio;
  num? volumeChapa;
  num? volumePerfil;

  ClienteModel(
      this.id,
      this.fantasia,
      this.razaoSocial,
      this.posicao,
      this.quantidadePedidos,
      this.pedidosAgrupados,
      this.idPedidosAgrupados,
      this.pedidosCarregados,
      this.idCliente,
      this.idSituacao,
      this.logradouro,
      this.endereco,
      this.numero,
      this.complemento,
      this.bairro,
      this.cidade,
      this.estado,
      this.cep,
      this.volumeAcessorio,
      this.volumeChapa,
      this.volumePerfil);

  ClienteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fantasia = json['fantasia'];
    razaoSocial = json['razaoSocial'];
    posicao = json['posicao'];
    quantidadePedidos = json['quantidadePedidos'];
    pedidosAgrupados = json['pedidosAgrupados'];
    idPedidosAgrupados = json['idPedidosAgrupados'];
    pedidosCarregados = json['pedidosCarregados'];
    idCliente = json['idCliente'];
    idSituacao = json['idSituacao'];
    logradouro = json['logradouro'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
    volumeAcessorio = json['volumeAcessorio'];
    volumeChapa = json['volumeChapa'];
    volumePerfil = json['volumePerfil'];
  }

  String enderecoCompleto() {
    if (endereco == null) {
      return '';
    } else {
      if (complemento != '') {
        return '$logradouro $endereco, $numero - $complemento - $bairro - $cidade - $estado - $cep.';
      } else {
        return '$logradouro $endereco, $numero - $bairro - $cidade - $estado - $cep.';
      }
    }
  }
}
