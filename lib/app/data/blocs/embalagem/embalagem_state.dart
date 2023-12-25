abstract class EmbalagemState {
  final List<dynamic> embalagens;

  EmbalagemState({required this.embalagens});
}

class EmbalagemInitialState extends EmbalagemState {
  EmbalagemInitialState() : super(embalagens: []);
}

class EmbalagemLoadingState extends EmbalagemState {
  EmbalagemLoadingState() : super(embalagens: []);
}

class EmbalagemLoadedState extends EmbalagemState {
  EmbalagemLoadedState({required List<dynamic> embalagens})
      : super(embalagens: embalagens);
}

class EmbalagemErrorState extends EmbalagemState {
  final String exception;

  EmbalagemErrorState({required this.exception}) : super(embalagens: []);
}
