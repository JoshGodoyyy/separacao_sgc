import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgc/app/data/blocs/pedido_event.dart';
import 'package:sgc/app/data/blocs/pedido_state.dart';

class PedidosBloc extends Bloc<PedidoEvent, PedidoState> {
  PedidosBloc() : super(PedidoInitialState());

  Stream<PedidoState> mapEventToState(PedidoEvent event) async* {
    if (event is GetPedidosSituacao) {
      yield PedidoInitialState();
    }
  }
}
