abstract class GrupoState {
  final List<dynamic> grupos;

  GrupoState({required this.grupos});
}

class GrupoInitialState extends GrupoState {
  GrupoInitialState() : super(grupos: []);
}

class GrupoLoadingState extends GrupoState {
  GrupoLoadingState() : super(grupos: []);
}

class GrupoLoadedState extends GrupoState {
  GrupoLoadedState({required List<dynamic> grupos}) : super(grupos: grupos);
}

class GrupoErrorState extends GrupoState {
  final String exception;

  GrupoErrorState({required this.exception}) : super(grupos: []);
}
