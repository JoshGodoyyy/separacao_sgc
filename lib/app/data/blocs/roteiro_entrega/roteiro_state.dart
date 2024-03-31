abstract class RoteiroState {
  final List roteiros;

  RoteiroState({required this.roteiros});
}

class RoteiroInitialState extends RoteiroState {
  RoteiroInitialState() : super(roteiros: []);
}

class RoteiroLoadingState extends RoteiroState {
  RoteiroLoadingState() : super(roteiros: []);
}

class RoteiroLoadedState extends RoteiroState {
  RoteiroLoadedState({required super.roteiros});
}

class RoteiroErrorState extends RoteiroState {
  final String exception;

  RoteiroErrorState({required this.exception}) : super(roteiros: []);
}
