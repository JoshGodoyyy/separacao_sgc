import 'package:intl/intl.dart';
import 'package:sgc/app/config/user.dart';

import '../../data/blocs/pedido/pedido_bloc.dart';
import '../../data/blocs/pedido/pedido_event.dart';
import '../../data/enums/situacao_pedido.dart';
import '../../data/repositories/pedido.dart';

class AlterarStatusPedido {
  final PedidoBloc _pedido = PedidoBloc();
  final DateFormat _data = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> enviarSeparacao(
    SituacaoPedido situacao,
    int autorizado,
    int id,
    int tipoProduto,
    String dataEnvioSeparacao,
  ) async {
    if (autorizado != 1) {
      throw Exception('É necessário autorizar o pedido para esta operação');
    }

    int sepPerfil = await Pedido().getSeparacao(id, 'sepPerfil');
    int sepAcessorio = await Pedido().getSeparacao(id, 'sepAcessorio');

    if (tipoProduto == 2) {
      sepPerfil = situacao.index + 1;
    } else {
      sepAcessorio = situacao.index + 1;
    }

    _pedido.inputPedido.add(
      EnviarSeparacao(
        idSituacao: situacao.index + 1,
        dataLiberacaoSeparacao: _data.format(DateTime.now()).toString(),
        dataEnvioSeparacao: _data
            .format(
              DateTime.parse(
                dataEnvioSeparacao,
              ),
            )
            .toString(),
        idIniciarSeparacao: UserConstants().idLiberacao ?? '',
        sepAcessorio: sepAcessorio,
        sepPerfil: sepPerfil,
        id: id,
      ),
    );
  }

  Future<void> enviarEmbalagem(
    String status,
    int id,
    int tipoProduto,
    String observacoesSeparacao,
  ) async {
    if (status == 'NOVO' || status == 'SEPARAR') {
      throw Exception(
        'É necessário iniciar a separação antes de conclui-la',
      );
    }

    int sepPerfil = await Pedido().getSeparacao(id, 'sepPerfil');
    int sepAcessorio = await Pedido().getSeparacao(id, 'sepAcessorio');

    _pedido.inputPedido.add(
      EnviarEmbalagem(
        idSituacao: 14,
        sepAcessorio: sepAcessorio,
        sepPerfil: sepPerfil,
        idSeparador: 1,
        idConcluirSeparacao: UserConstants().idLiberacao ?? '',
        dataRetornoSeparacao: _data.format(DateTime.now()).toString(),
        observacoesSeparacao: observacoesSeparacao,
        id: id,
      ),
    );
  }

  Future<void> liberarConferencia(
    String status,
    String observacoesSeparacao,
    int id,
  ) async {
    if (status == 'NOVO' || status == 'SEPARAR') {
      throw Exception(
        'É necessário iniciar a separação antes de conclui-la',
      );
    }

    _pedido.inputPedido.add(
      LiberarConferencia(
        idSituacao: 15,
        observacoesSeparacao: observacoesSeparacao,
        id: id,
      ),
    );
  }

  // Future<void> _finalizarSeparacao() async {
  //   if (widget.pedido.status.toString().toUpperCase() == 'NOVO' ||
  //       widget.pedido.status.toString().toUpperCase() == 'SEPARAR') {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const CustomDialog(
  //           titulo: 'SGC Mobile',
  //           descricao: 'É necessário iniciar a separação antes de conclui-la',
  //           tipo: Icones.erro,
  //         );
  //       },
  //     );
  //   }
  // }
}
