class ClienteModel {
  num? id;
  num? idRoteiroEntrega;
  num? pesoTotal;
  String? tratamentoItens;
  String? tratamentoEspecial;
  String? fantasia;
  String? razaoSocial;
  num? posicao;
  num? quantidadePedidos;
  String? pedidosAgrupados;
  num? idCliente;
  num? pedidosCarregados;
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
      this.pesoTotal,
      this.tratamentoItens,
      this.tratamentoEspecial,
      this.razaoSocial,
      this.posicao,
      this.quantidadePedidos,
      this.pedidosAgrupados,
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
    pesoTotal = json['pesoTotal'];
    tratamentoItens = json['tratamentoItens'];
    tratamentoEspecial = json['tratamentoEspecial'];
    fantasia = json['fantasia'];
    razaoSocial = json['razaoSocial'];
    posicao = json['posicao'];
    quantidadePedidos = json['quantidadePedidos'];
    pedidosAgrupados = json['pedidosAgrupados'];
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
      return 'ENDEREÇO NÃO INFORMADO';
    } else {
      String logradouro = this.logradouro == '' || this.logradouro == null
          ? ''
          : this.logradouro!;
      String numero =
          this.numero == '' || this.numero == null ? '' : ', ${this.numero!}';

      if (complemento != '' && complemento != null) {
        return '$logradouro $endereco$numero - $complemento - $bairro - $cidade - $estado - $cep.'
            .trimLeft();
      } else {
        return '$logradouro $endereco$numero - $bairro - $cidade - $estado - $cep.'
            .trimLeft();
      }
    }
  }
}
