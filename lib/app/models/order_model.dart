class Pedido {
  num? id;
  String? dataCriacao;
  num? idCriador;
  num? idCliente;
  num? idSituacao;
  String? nomeCliente;
  String? razaoSocial;
  String? observacoes;
  String? dataEntrega;
  num? idTipoEntrega;
  String? tipoEntrega;
  num? valorTotal;
  num? pesoTotal;
  String? cidade;
  String? estado;
  num? idTipoPedido;
  num? idTipoSituacao;
  String? status;
  String? fantasia;
  num? idOrcamento;
  String? setorEstoque;
  num? autorizado;
  num? idTipoVenda;
  num? idTratamento;
  num? tratamentoSeparado;
  num? tratamentoEnviado;
  String? idPedidoCliente;
  num? idCompra;
  String? pedidosAgrupados;
  num? volumePerfil;
  num? volumeChapa;
  num? volumeAcessorio;
  String? observacoesSeparacao;
  String? observacoesSeparador;
  String? observacoesFinanceiro;
  String? tipoPagamento;
  String? criador;
  String? tratamentoItens;
  String? separadorIniciar;
  String? separadorConcluir;
  String? dataLiberacaoSeparacao;
  String? dataEnvioSeparacao;
  String? dataRetornoSeparacao;
  num? idVendedor;
  String? remessa;
  String? prazoPagamento;
  num? idTabela;
  num? entregaFaturamento;
  num? faturamentoComponentes;
  num? solicitacaoAprovacao;
  String? justificativaAprovacao;
  String? respostaAprovacao;
  num? aberto;
  String? tipoPessoa;
  String? cnpj;
  String? ie;
  String? cep;
  String? logradouro;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  num? pesoTotalTeorico;
  num? valorTotalTeorico;
  num? idFormaPagamento;
  num? nroParcelas;
  num? primeiraParcela;
  num? demaisParcelas;
  num? desconto;
  num? valorFrete;
  String? telefone;
  String? fax;
  num? nroNfe;
  String? dataFechamento;
  num? idUsuarioFechamento;
  num? formaSaldoRecebimento;
  num? idSeparador;
  num? idEnvioTratamento;
  String? setorEntrega;
  String? fatProduto;
  num? fatPeso;
  num? fatValor;
  String? autorizadoData;
  num? autorizadoIdUsuario;
  num? autorizadoNroParcela;
  num? autorizadoPrimeiraParcela;
  num? autorizadoDemaisParcelas;
  num? autorizadoValor;
  String? autorizadoObservacao;
  num? triangulacao;
  num? idFornNFe;
  num? idTranspNFe;
  num? pagamentoFrete;
  String? obsNFeVenda;
  String? obsNFeRemessa;
  String? fatProduto2;
  num? fatPeso2;
  num? fatValor2;
  num? remId;
  num? remSubId;
  String? transpPlaca;
  String? transpUf;
  String? transpRntc;
  num? impressaoSeparacao;
  num? saldoEncomenda;
  num? idGrupoFaturamento;
  num? autorizadoIdPagamento;
  num? tpFornNFe;
  String? entCNPJ;
  String? entLogradouro;
  String? entNomeRua;
  String? entNumero;
  String? entCEP;
  String? entComplemento;
  String? entBairro;
  String? entCidade;
  String? entEstado;
  num? idEmpresa;
  num? pesoAcessorios;
  num? idFinalidadeCompra;
  num? pDesconto;
  String? tratamento;
  num? isencaoIPI;
  num? isencaoPIS;
  num? isencaoCOFINS;
  num? isencaoICMS;
  num? isencaoST;
  String? observacoesTratamento;
  num? suframa;
  num? porcentagem;
  num? transpEntregar;
  num? aCombinar;
  String? autorizadoPrazoPagamento;
  String? dataAtualizacao;
  num? idPedidoCompraPerfil;
  num? idPedidoCompraAcessorio;
  num? idPedidoTratamento;
  num? idPedidoEncomenda;
  num? sinal;
  num? idSubCliente;
  num? tratarPerfilAcessorioPedido;
  num? idFornTri;
  num? idCliNFe;
  num? idCliTri;
  num? nnFeVenda;
  num? nnFeRemessa;
  String? fantasiaTri;
  String? cidadeTri;
  String? estadoTri;
  num? idProtocoloRecebimento;
  num? idEncomenda;
  num? custoNatural;
  num? processarFaturamento;

  Pedido(
      {id,
      dataCriacao,
      idCriador,
      idCliente,
      idSituacao,
      nomeCliente,
      razaoSocial,
      observacoes,
      dataEntrega,
      idTipoEntrega,
      tipoEntrega,
      valorTotal,
      pesoTotal,
      cidade,
      estado,
      idTipoPedido,
      idTipoSituacao,
      status,
      fantasia,
      idOrcamento,
      setorEstoque,
      autorizado,
      idTipoVenda,
      idTratamento,
      tratamentoSeparado,
      tratamentoEnviado,
      idPedidoCliente,
      idCompra,
      pedidosAgrupados,
      volumePerfil,
      volumeChapa,
      volumeAcessorio,
      observacoesSeparacao,
      observacoesSeparador,
      observacoesFinanceiro,
      tipoPagamento,
      criador,
      tratamentoItens,
      separadorIniciar,
      separadorConcluir,
      dataLiberacaoSeparacao,
      dataEnvioSeparacao,
      dataRetornoSeparacao,
      idVendedor,
      remessa,
      prazoPagamento,
      idTabela,
      entregaFaturamento,
      faturamentoComponentes,
      solicitacaoAprovacao,
      justificativaAprovacao,
      respostaAprovacao,
      aberto,
      tipoPessoa,
      cnpj,
      ie,
      cep,
      logradouro,
      endereco,
      numero,
      complemento,
      bairro,
      pesoTotalTeorico,
      valorTotalTeorico,
      idFormaPagamento,
      nroParcelas,
      primeiraParcela,
      demaisParcelas,
      desconto,
      valorFrete,
      telefone,
      fax,
      nroNfe,
      dataFechamento,
      idUsuarioFechamento,
      formaSaldoRecebimento,
      idSeparador,
      idEnvioTratamento,
      setorEntrega,
      fatProduto,
      fatPeso,
      fatValor,
      autorizadoData,
      autorizadoIdUsuario,
      autorizadoNroParcela,
      autorizadoPrimeiraParcela,
      autorizadoDemaisParcelas,
      autorizadoValor,
      autorizadoObservacao,
      triangulacao,
      idFornNFe,
      idTranspNFe,
      pagamentoFrete,
      obsNFeVenda,
      obsNFeRemessa,
      fatProduto2,
      fatPeso2,
      fatValor2,
      remId,
      remSubId,
      transpPlaca,
      transpUf,
      transpRntc,
      impressaoSeparacao,
      saldoEncomenda,
      idGrupoFaturamento,
      autorizadoIdPagamento,
      tpFornNFe,
      entCNPJ,
      entLogradouro,
      entNomeRua,
      entNumero,
      entCEP,
      entComplemento,
      entBairro,
      entCidade,
      entEstado,
      idEmpresa,
      pesoAcessorios,
      idFinalidadeCompra,
      pDesconto,
      tratamento,
      isencaoIPI,
      isencaoPIS,
      isencaoCOFINS,
      isencaoICMS,
      isencaoST,
      observacoesTratamento,
      suframa,
      porcentagem,
      transpEntregar,
      aCombinar,
      autorizadoPrazoPagamento,
      dataAtualizacao,
      idPedidoCompraPerfil,
      idPedidoCompraAcessorio,
      idPedidoTratamento,
      idPedidoEncomenda,
      sinal,
      idSubCliente,
      tratarPerfilAcessorioPedido,
      idFornTri,
      idCliNFe,
      idCliTri,
      nnFeVenda,
      nnFeRemessa,
      fantasiaTri,
      cidadeTri,
      estadoTri,
      idProtocoloRecebimento,
      idEncomenda,
      custoNatural,
      processarFaturamento});

  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataCriacao = json['dataCriacao'];
    idCriador = json['idCriador'];
    idCliente = json['idCliente'];
    idSituacao = json['idSituacao'];
    nomeCliente = json['nomeCliente'];
    razaoSocial = json['razaoSocial'];
    observacoes = json['observacoes'];
    dataEntrega = json['dataEntrega'];
    idTipoEntrega = json['idTipoEntrega'];
    tipoEntrega = json['tipoEntrega'];
    valorTotal = json['valorTotal'];
    pesoTotal = json['pesoTotal'];
    cidade = json['cidade'];
    estado = json['estado'];
    idTipoPedido = json['idTipoPedido'];
    idTipoSituacao = json['idTipoSituacao'];
    status = json['status'];
    fantasia = json['fantasia'];
    idOrcamento = json['idOrcamento'];
    setorEstoque = json['setorEstoque'];
    autorizado = json['autorizado'];
    idTipoVenda = json['idTipoVenda'];
    idTratamento = json['idTratamento'];
    tratamentoSeparado = json['tratamentoSeparado'];
    tratamentoEnviado = json['tratamentoEnviado'];
    idPedidoCliente = json['idPedidoCliente'];
    idCompra = json['idCompra'];
    pedidosAgrupados = json['pedidosAgrupados'];
    volumePerfil = json['volumePerfil'];
    volumeChapa = json['volumeChapa'];
    volumeAcessorio = json['volumeAcessorio'];
    observacoesSeparacao = json['observacoesSeparacao'];
    observacoesSeparador = json['observacoesSeparador'];
    observacoesFinanceiro = json['observacoesFinanceiro'];
    tipoPagamento = json['tipoPagamento'];
    criador = json['criador'];
    tratamentoItens = json['tratamentoItens'];
    separadorIniciar = json['separadorIniciar'];
    separadorConcluir = json['separadorConcluir'];
    dataLiberacaoSeparacao = json['dataLiberacaoSeparacao'];
    dataEnvioSeparacao = json['dataEnvioSeparacao'];
    dataRetornoSeparacao = json['dataRetornoSeparacao'];
    idVendedor = json['idVendedor'];
    remessa = json['remessa'];
    prazoPagamento = json['prazoPagamento'];
    idTabela = json['idTabela'];
    entregaFaturamento = json['entregaFaturamento'];
    faturamentoComponentes = json['faturamentoComponentes'];
    solicitacaoAprovacao = json['solicitacaoAprovacao'];
    justificativaAprovacao = json['justificativaAprovacao'];
    respostaAprovacao = json['respostaAprovacao'];
    aberto = json['aberto'];
    tipoPessoa = json['tipoPessoa'];
    cnpj = json['cnpj'];
    ie = json['ie'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    pesoTotalTeorico = json['pesoTotalTeorico'];
    valorTotalTeorico = json['valorTotalTeorico'];
    idFormaPagamento = json['idFormaPagamento'];
    nroParcelas = json['nroParcelas'];
    primeiraParcela = json['primeiraParcela'];
    demaisParcelas = json['demaisParcelas'];
    desconto = json['desconto'];
    valorFrete = json['valorFrete'];
    telefone = json['telefone'];
    fax = json['fax'];
    nroNfe = json['nroNfe'];
    dataFechamento = json['dataFechamento'];
    idUsuarioFechamento = json['idUsuarioFechamento'];
    formaSaldoRecebimento = json['formaSaldoRecebimento'];
    idSeparador = json['idSeparador'];
    idEnvioTratamento = json['idEnvioTratamento'];
    setorEntrega = json['setorEntrega'];
    fatProduto = json['fat_Produto'];
    fatPeso = json['fat_Peso'];
    fatValor = json['fat_Valor'];
    autorizadoData = json['autorizadoData'];
    autorizadoIdUsuario = json['autorizadoIdUsuario'];
    autorizadoNroParcela = json['autorizadoNroParcela'];
    autorizadoPrimeiraParcela = json['autorizadoPrimeiraParcela'];
    autorizadoDemaisParcelas = json['autorizadoDemaisParcelas'];
    autorizadoValor = json['autorizadoValor'];
    autorizadoObservacao = json['autorizadoObservacao'];
    triangulacao = json['triangulacao'];
    idFornNFe = json['idFornNFe'];
    idTranspNFe = json['idTranspNFe'];
    pagamentoFrete = json['pagamentoFrete'];
    obsNFeVenda = json['obsNFeVenda'];
    obsNFeRemessa = json['obsNFeRemessa'];
    fatProduto2 = json['fat_Produto2'];
    fatPeso2 = json['fat_Peso2'];
    fatValor2 = json['fat_Valor2'];
    remId = json['rem_Id'];
    remSubId = json['rem_SubId'];
    transpPlaca = json['transpPlaca'];
    transpUf = json['transpUf'];
    transpRntc = json['transpRntc'];
    impressaoSeparacao = json['impressaoSeparacao'];
    saldoEncomenda = json['saldoEncomenda'];
    idGrupoFaturamento = json['idGrupoFaturamento'];
    autorizadoIdPagamento = json['autorizadoIdPagamento'];
    tpFornNFe = json['tpFornNFe'];
    entCNPJ = json['ent_CNPJ'];
    entLogradouro = json['ent_Logradouro'];
    entNomeRua = json['ent_NomeRua'];
    entNumero = json['ent_Numero'];
    entCEP = json['ent_CEP'];
    entComplemento = json['ent_Complemento'];
    entBairro = json['ent_Bairro'];
    entCidade = json['ent_Cidade'];
    entEstado = json['ent_Estado'];
    idEmpresa = json['idEmpresa'];
    pesoAcessorios = json['pesoAcessorios'];
    idFinalidadeCompra = json['idFinalidadeCompra'];
    pDesconto = json['pDesconto'];
    tratamento = json['tratamento'];
    isencaoIPI = json['isencaoIPI'];
    isencaoPIS = json['isencaoPIS'];
    isencaoCOFINS = json['isencaoCOFINS'];
    isencaoICMS = json['isencaoICMS'];
    isencaoST = json['isencaoST'];
    observacoesTratamento = json['observacoesTratamento'];
    suframa = json['suframa'];
    porcentagem = json['porcentagem'];
    transpEntregar = json['transpEntregar'];
    aCombinar = json['aCombinar'];
    autorizadoPrazoPagamento = json['autorizadoPrazoPagamento'];
    dataAtualizacao = json['dataAtualizacao'];
    idPedidoCompraPerfil = json['idPedidoCompraPerfil'];
    idPedidoCompraAcessorio = json['idPedidoCompraAcessorio'];
    idPedidoTratamento = json['idPedidoTratamento'];
    idPedidoEncomenda = json['idPedidoEncomenda'];
    sinal = json['sinal'];
    idSubCliente = json['idSubCliente'];
    tratarPerfilAcessorioPedido = json['tratarPerfilAcessorioPedido'];
    idFornTri = json['idFornTri'];
    idCliNFe = json['idCliNFe'];
    idCliTri = json['idCliTri'];
    nnFeVenda = json['nnFeVenda'];
    nnFeRemessa = json['nnFeRemessa'];
    fantasiaTri = json['fantasiaTri'];
    cidadeTri = json['cidadeTri'];
    estadoTri = json['estadoTri'];
    idProtocoloRecebimento = json['idProtocoloRecebimento'];
    idEncomenda = json['idEncomenda'];
    custoNatural = json['custoNatural'];
    processarFaturamento = json['processarFaturamento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dataCriacao'] = dataCriacao;
    data['idCriador'] = idCriador;
    data['idCliente'] = idCliente;
    data['idSituacao'] = idSituacao;
    data['nomeCliente'] = nomeCliente;
    data['razaoSocial'] = razaoSocial;
    data['observacoes'] = observacoes;
    data['dataEntrega'] = dataEntrega;
    data['idTipoEntrega'] = idTipoEntrega;
    data['tipoEntrega'] = tipoEntrega;
    data['valorTotal'] = valorTotal;
    data['pesoTotal'] = pesoTotal;
    data['cidade'] = cidade;
    data['estado'] = estado;
    data['idTipoPedido'] = idTipoPedido;
    data['idTipoSituacao'] = idTipoSituacao;
    data['status'] = status;
    data['fantasia'] = fantasia;
    data['idOrcamento'] = idOrcamento;
    data['setorEstoque'] = setorEstoque;
    data['autorizado'] = autorizado;
    data['idTipoVenda'] = idTipoVenda;
    data['idTratamento'] = idTratamento;
    data['tratamentoSeparado'] = tratamentoSeparado;
    data['tratamentoEnviado'] = tratamentoEnviado;
    data['idPedidoCliente'] = idPedidoCliente;
    data['idCompra'] = idCompra;
    data['pedidosAgrupados'] = pedidosAgrupados;
    data['volumePerfil'] = volumePerfil;
    data['volumeChapa'] = volumeChapa;
    data['volumeAcessorio'] = volumeAcessorio;
    data['observacoesSeparacao'] = observacoesSeparacao;
    data['observacoesSeparador'] = observacoesSeparador;
    data['observacoesFinanceiro'] = observacoesFinanceiro;
    data['tipoPagamento'] = tipoPagamento;
    data['criador'] = criador;
    data['tratamentoItens'] = tratamentoItens;
    data['separadorIniciar'] = separadorIniciar;
    data['separadorConcluir'] = separadorConcluir;
    data['dataLiberacaoSeparacao'] = dataLiberacaoSeparacao;
    data['dataEnvioSeparacao'] = dataEnvioSeparacao;
    data['dataRetornoSeparacao'] = dataRetornoSeparacao;
    data['idVendedor'] = idVendedor;
    data['remessa'] = remessa;
    data['prazoPagamento'] = prazoPagamento;
    data['idTabela'] = idTabela;
    data['entregaFaturamento'] = entregaFaturamento;
    data['faturamentoComponentes'] = faturamentoComponentes;
    data['solicitacaoAprovacao'] = solicitacaoAprovacao;
    data['justificativaAprovacao'] = justificativaAprovacao;
    data['respostaAprovacao'] = respostaAprovacao;
    data['aberto'] = aberto;
    data['tipoPessoa'] = tipoPessoa;
    data['cnpj'] = cnpj;
    data['ie'] = ie;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['endereco'] = endereco;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['pesoTotalTeorico'] = pesoTotalTeorico;
    data['valorTotalTeorico'] = valorTotalTeorico;
    data['idFormaPagamento'] = idFormaPagamento;
    data['nroParcelas'] = nroParcelas;
    data['primeiraParcela'] = primeiraParcela;
    data['demaisParcelas'] = demaisParcelas;
    data['desconto'] = desconto;
    data['valorFrete'] = valorFrete;
    data['telefone'] = telefone;
    data['fax'] = fax;
    data['nroNfe'] = nroNfe;
    data['dataFechamento'] = dataFechamento;
    data['idUsuarioFechamento'] = idUsuarioFechamento;
    data['formaSaldoRecebimento'] = formaSaldoRecebimento;
    data['idSeparador'] = idSeparador;
    data['idEnvioTratamento'] = idEnvioTratamento;
    data['setorEntrega'] = setorEntrega;
    data['fat_Produto'] = fatProduto;
    data['fat_Peso'] = fatPeso;
    data['fat_Valor'] = fatValor;
    data['autorizadoData'] = autorizadoData;
    data['autorizadoIdUsuario'] = autorizadoIdUsuario;
    data['autorizadoNroParcela'] = autorizadoNroParcela;
    data['autorizadoPrimeiraParcela'] = autorizadoPrimeiraParcela;
    data['autorizadoDemaisParcelas'] = autorizadoDemaisParcelas;
    data['autorizadoValor'] = autorizadoValor;
    data['autorizadoObservacao'] = autorizadoObservacao;
    data['triangulacao'] = triangulacao;
    data['idFornNFe'] = idFornNFe;
    data['idTranspNFe'] = idTranspNFe;
    data['pagamentoFrete'] = pagamentoFrete;
    data['obsNFeVenda'] = obsNFeVenda;
    data['obsNFeRemessa'] = obsNFeRemessa;
    data['fat_Produto2'] = fatProduto2;
    data['fat_Peso2'] = fatPeso2;
    data['fat_Valor2'] = fatValor2;
    data['rem_Id'] = remId;
    data['rem_SubId'] = remSubId;
    data['transpPlaca'] = transpPlaca;
    data['transpUf'] = transpUf;
    data['transpRntc'] = transpRntc;
    data['impressaoSeparacao'] = impressaoSeparacao;
    data['saldoEncomenda'] = saldoEncomenda;
    data['idGrupoFaturamento'] = idGrupoFaturamento;
    data['autorizadoIdPagamento'] = autorizadoIdPagamento;
    data['tpFornNFe'] = tpFornNFe;
    data['ent_CNPJ'] = entCNPJ;
    data['ent_Logradouro'] = entLogradouro;
    data['ent_NomeRua'] = entNomeRua;
    data['ent_Numero'] = entNumero;
    data['ent_CEP'] = entCEP;
    data['ent_Complemento'] = entComplemento;
    data['ent_Bairro'] = entBairro;
    data['ent_Cidade'] = entCidade;
    data['ent_Estado'] = entEstado;
    data['idEmpresa'] = idEmpresa;
    data['pesoAcessorios'] = pesoAcessorios;
    data['idFinalidadeCompra'] = idFinalidadeCompra;
    data['pDesconto'] = pDesconto;
    data['tratamento'] = tratamento;
    data['isencaoIPI'] = isencaoIPI;
    data['isencaoPIS'] = isencaoPIS;
    data['isencaoCOFINS'] = isencaoCOFINS;
    data['isencaoICMS'] = isencaoICMS;
    data['isencaoST'] = isencaoST;
    data['observacoesTratamento'] = observacoesTratamento;
    data['suframa'] = suframa;
    data['porcentagem'] = porcentagem;
    data['transpEntregar'] = transpEntregar;
    data['aCombinar'] = aCombinar;
    data['autorizadoPrazoPagamento'] = autorizadoPrazoPagamento;
    data['dataAtualizacao'] = dataAtualizacao;
    data['idPedidoCompraPerfil'] = idPedidoCompraPerfil;
    data['idPedidoCompraAcessorio'] = idPedidoCompraAcessorio;
    data['idPedidoTratamento'] = idPedidoTratamento;
    data['idPedidoEncomenda'] = idPedidoEncomenda;
    data['sinal'] = sinal;
    data['idSubCliente'] = idSubCliente;
    data['tratarPerfilAcessorioPedido'] = tratarPerfilAcessorioPedido;
    data['idFornTri'] = idFornTri;
    data['idCliNFe'] = idCliNFe;
    data['idCliTri'] = idCliTri;
    data['nnFeVenda'] = nnFeVenda;
    data['nnFeRemessa'] = nnFeRemessa;
    data['fantasiaTri'] = fantasiaTri;
    data['cidadeTri'] = cidadeTri;
    data['estadoTri'] = estadoTri;
    data['idProtocoloRecebimento'] = idProtocoloRecebimento;
    data['idEncomenda'] = idEncomenda;
    data['custoNatural'] = custoNatural;
    data['processarFaturamento'] = processarFaturamento;
    return data;
  }
}
