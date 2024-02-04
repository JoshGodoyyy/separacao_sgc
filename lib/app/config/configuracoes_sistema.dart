class ConfiguracoesSistema {
  static final ConfiguracoesSistema _configuracoes =
      ConfiguracoesSistema._internal();

  factory ConfiguracoesSistema() {
    return _configuracoes;
  }

  ConfiguracoesSistema._internal();

  int? _fechamentoPedAntSeparacao;

  int? get fechamentoPedAntSeparacao => _fechamentoPedAntSeparacao;

  void setFechamento(int value) {
    _fechamentoPedAntSeparacao = value;
  }
}
