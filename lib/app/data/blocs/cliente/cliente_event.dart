abstract class ClienteEvent {}

class GetClientes extends ClienteEvent {
  final int idRoteiroEntrega;
  final bool pedidosAgrupados;

  GetClientes({
    required this.idRoteiroEntrega,
    required this.pedidosAgrupados,
  });
}
