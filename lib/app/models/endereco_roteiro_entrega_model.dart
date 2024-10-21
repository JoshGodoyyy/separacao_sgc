class EnderecoRoteiroEntregaModel {
  num? id;
  String? observacoesMotorista;
  String? pedidosAgrupados;
  num? idCliente;
  String? fantasia;
  String? razaoSocial;
  num? posicao;
  num? idSituacao;
  String? logradouro;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  num? idRoteiroEntrega;

  EnderecoRoteiroEntregaModel({
    this.id,
    this.observacoesMotorista,
    this.pedidosAgrupados,
    this.idCliente,
    this.fantasia,
    this.razaoSocial,
    this.posicao,
    this.idSituacao,
    this.logradouro,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.idRoteiroEntrega,
  });

  EnderecoRoteiroEntregaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observacoesMotorista = json['observacoesMotorista'];
    pedidosAgrupados = json['pedidosAgrupados'];
    idCliente = json['idCliente'];
    fantasia = json['fantasia'];
    razaoSocial = json['razaoSocial'];
    posicao = json['posicao'];
    idSituacao = json['idSituacao'];
    logradouro = json['logradouro'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
    idRoteiroEntrega = json['idRoteiroEntrega'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'observacoesMotorista': observacoesMotorista,
      'pedidosAgrupados': pedidosAgrupados,
      'idCliente': idCliente,
      'fantasia': fantasia,
      'razaoSocial': razaoSocial,
      'posicao': posicao,
      'idSituacao': idSituacao,
      'logradouro': logradouro,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'idRoteiroEntrega': idRoteiroEntrega,
    };
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
