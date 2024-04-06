abstract class RoteiroEvent {}

class GetRoteiros extends RoteiroEvent {
  GetRoteiros();
}

class ConcluirCarregamento extends RoteiroEvent {
  final int idRoteiro;
  ConcluirCarregamento({required this.idRoteiro});
}
