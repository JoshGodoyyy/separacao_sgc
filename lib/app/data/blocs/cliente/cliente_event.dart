abstract class ClienteEvent {}

class GetClientes extends ClienteEvent {
  final int idRoteiroEntrega;

  GetClientes({required this.idRoteiroEntrega});
}
