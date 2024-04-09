import 'package:sgc/app/models/roteiro_entrega_model.dart';

abstract class RoteiroState {
  final RoteiroEntregaModel? roteiro;

  RoteiroState({required this.roteiro});
}

class RoteiroInitialState extends RoteiroState {
  RoteiroInitialState() : super(roteiro: null);
}

class RoteiroLoadingState extends RoteiroState {
  RoteiroLoadingState() : super(roteiro: null);
}

class RoteiroLoadedState extends RoteiroState {
  RoteiroLoadedState({required super.roteiro});
}

class RoteiroErrorState extends RoteiroState {
  final String exception;

  RoteiroErrorState({required this.exception}) : super(roteiro: null);
}
