import 'package:intl/intl.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/repositories/produto.dart';
import 'package:sgc/app/models/group_model.dart';

import '../../data/blocs/pedido/pedido_bloc.dart';
import '../../data/blocs/pedido/pedido_event.dart';
import '../../data/repositories/grupo.dart';
import '../../data/repositories/grupo_pedido.dart';
import '../../data/repositories/nivel_senha.dart';
import '../../data/repositories/pedido.dart';
import '../../models/nivel_senha_model.dart';

class AlterarStatusPedido {
  final PedidoBloc _pedido = PedidoBloc();
  final DateFormat _data = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> enviarSeparacao(
    int idSituacao,
    String status,
    int autorizado,
    int id,
    int tipoProduto,
    String dataEnvioSeparacao,
  ) async {
    int sepPerfil = await Pedido().getSeparacao(id, 'sepPerfil');
    int sepAcessorio = await Pedido().getSeparacao(id, 'sepAcessorio');

    if (status.toUpperCase() != 'SEPARAR' && status.toUpperCase() != 'NOVO') {
      throw Exception('Pedido não pode ser alterado');
    }

    final nivelUsuario = NivelSenhaModel(
      idUsuario: UserConstants().idUsuario,
      nivel: 'VenPedSepIni',
    );

    bool nivelSenhaAutorizado =
        await NivelSenha().verificarNivelSenha(nivelUsuario);

    if (!nivelSenhaAutorizado) {
      throw Exception('Nível de Senha requerido: ${nivelUsuario.nivel}');
    }

    if (autorizado != 1) {
      throw Exception('É necessário autorizar o pedido para esta operação');
    }

    if (tipoProduto == 2) {
      sepPerfil = 3;
    } else {
      sepAcessorio = 3;
    }

    _pedido.inputPedido.add(
      EnviarSeparacao(
        idSituacao: 3,
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
    final nivelUsuario = NivelSenhaModel(
      idUsuario: UserConstants().idUsuario,
      nivel: 'VenPedSepEmb',
    );

    bool nivelSenhaAutorizado =
        await NivelSenha().verificarNivelSenha(nivelUsuario);

    if (!nivelSenhaAutorizado) {
      throw Exception('Nível de Senha requerido: ${nivelUsuario.nivel}');
    }

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
        idSeparador: int.parse(
          UserConstants().idUsuario.toString(),
        ),
        idConcluirSeparacao: UserConstants().idLiberacao ?? '',
        dataRetornoSeparacao: _data.format(DateTime.now()).toString(),
        observacoesSeparacao: observacoesSeparacao,
        id: id,
        tipoProduto: tipoProduto,
      ),
    );
  }

  Future<void> liberarConferencia(
    String status,
    String observacoesSeparacao,
    int id,
  ) async {
    final nivelUsuario = NivelSenhaModel(
      idUsuario: UserConstants().idUsuario,
      nivel: 'VenPedSepConf',
    );

    bool nivelSenhaAutorizado =
        await NivelSenha().verificarNivelSenha(nivelUsuario);

    if (!nivelSenhaAutorizado) {
      throw Exception('Nível de Senha requerido: ${nivelUsuario.nivel}');
    }

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

  Future<void> finalizarSeparacao(
    String status,
    String observacoesSeparacao,
    int volumePerfil,
    int volumeAcessorio,
    int volumeChapa,
    double pesoTotalTeorico,
    double valorTotalTeorico,
    int tipoProduto,
    int id,
  ) async {
    final nivelUsuario = NivelSenhaModel(
      idUsuario: UserConstants().idUsuario,
      nivel: 'VenPedSepIni',
    );

    bool nivelSenhaAutorizado =
        await NivelSenha().verificarNivelSenha(nivelUsuario);

    if (!nivelSenhaAutorizado) {
      throw Exception('Nível de Senha requerido: ${nivelUsuario.nivel}');
    }

    if (status == 'NOVO' || status == 'SEPARAR') {
      throw Exception(
        'É necessário iniciar a separação antes de conclui-la',
      );
    }

    await GrupoPedido().apagarGruposInconsistentes(id);

    var produtos = await Produto().fetchProdutos(
      tipoProduto,
      id,
    );

    var grupos = await Grupo().fetchGrupos(
      id,
      tipoProduto,
    );

    await Grupo().atualizarGruposPedidos(
      grupos,
      produtos,
    );

    produtos = await Produto().fetchProdutos(
      tipoProduto,
      id,
    );

    grupos = await Grupo().fetchGrupos(
      id,
      tipoProduto,
    );

    int sepPerfil = await Pedido().getSeparacao(id, 'sepPerfil');
    int sepAcessorio = await Pedido().getSeparacao(id, 'sepAcessorio');

    switch (tipoProduto) {
      case 2:
        sepPerfil = 5;
        break;
      case 3:
        sepAcessorio = 5;
        break;
      default:
        sepAcessorio = 5;
        sepPerfil = 5;
        break;
    }

    double pesoTotalReal = 0;
    double valorTotalReal = 0;

    for (GrupoModel grupo in grupos) {
      pesoTotalReal += double.parse(
        grupo.pesoReal.toString(),
      );

      valorTotalReal += double.parse(
        grupo.valorReal.toString(),
      );
    }

    _pedido.inputPedido.add(
      FinalizarSeparacao(
        idSituacao: 5,
        observacoesSeparacao: observacoesSeparacao,
        volumePerfil: volumePerfil,
        volumeAcessorio: volumeAcessorio,
        volumeChapa: volumeChapa,
        pesoTotalTeorico: pesoTotalTeorico,
        pesoTotalReal: pesoTotalReal,
        valorTotalTeorico: valorTotalTeorico,
        valorTotalReal: valorTotalReal,
        sepAcessorio: sepAcessorio,
        sepPerfil: sepPerfil,
        idSeparador: int.parse(
          UserConstants().idUsuario.toString(),
        ),
        chaveLiberacao: UserConstants().idLiberacao.toString(),
        id: id,
      ),
    );
  }
}
