abstract class RoteiroEvent {}

class GetRoteiro extends RoteiroEvent {
  final int idRoteiro;
  GetRoteiro({required this.idRoteiro});
}

class UpdateDados extends RoteiroEvent {
  final int idRoteiro;
  final double kmInicial;
  final String ajudante;
  final String horarioSaida;

  UpdateDados({
    required this.idRoteiro,
    required this.kmInicial,
    required this.ajudante,
    required this.horarioSaida,
  });
}

class FinishDados extends RoteiroEvent {
  final int idRoteiro;
  final double pedagio;
  final double combustivel;
  final double refeicao;
  final double kmFinal;

  FinishDados({
    required this.idRoteiro,
    required this.pedagio,
    required this.combustivel,
    required this.refeicao,
    required this.kmFinal,
  });
}
