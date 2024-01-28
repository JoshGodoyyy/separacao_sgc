abstract class SeparacaoState {
  final int result;

  SeparacaoState({required this.result});
}

class SeparacaoInitialState extends SeparacaoState {
  SeparacaoInitialState() : super(result: 0);
}

class SeparacaoLoadingState extends SeparacaoState {
  SeparacaoLoadingState() : super(result: 0);
}

class SeparacaoLoadedState extends SeparacaoState {
  SeparacaoLoadedState({required super.result});
}
