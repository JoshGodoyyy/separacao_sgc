import 'package:sgc/app/models/group_model.dart';

abstract class GrupoState {
  final GrupoModel? grupo;

  GrupoState({required this.grupo});
}

class GrupoInitialState extends GrupoState {
  GrupoInitialState() : super(grupo: null);
}

class GrupoLoadingState extends GrupoState {
  GrupoLoadingState() : super(grupo: null);
}

class GrupoLoadedState extends GrupoState {
  GrupoLoadedState({required GrupoModel grupo}) : super(grupo: grupo);
}

class GrupoErrorState extends GrupoState {
  final String exception;

  GrupoErrorState({required this.exception}) : super(grupo: null);
}
