abstract class EnderecoRoteiroState {
  final List enderecos;

  EnderecoRoteiroState({required this.enderecos});
}

class EnderecoRoteiroInitialState extends EnderecoRoteiroState {
  EnderecoRoteiroInitialState() : super(enderecos: []);
}

class EnderecoRoteiroLoadingState extends EnderecoRoteiroState {
  EnderecoRoteiroLoadingState() : super(enderecos: []);
}

class EnderecoRoteiroLoadedState extends EnderecoRoteiroState {
  EnderecoRoteiroLoadedState({required super.enderecos});
}

class EnderecoRoteiroErrorState extends EnderecoRoteiroState {
  final String exception;

  EnderecoRoteiroErrorState({required this.exception}) : super(enderecos: []);
}
