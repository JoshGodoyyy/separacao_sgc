import 'package:sgc/app/models/group_model.dart';

abstract class GrupoEvent {}

class GetGrupo extends GrupoEvent {
  final int idPedido;
  final int idTipoProduto;

  GetGrupo({required this.idPedido, required this.idTipoProduto});
}

class PostGrupo extends GrupoEvent {
  final GrupoModel grupo;

  PostGrupo({required this.grupo});
}

class UpdateGrupo extends GrupoEvent {
  final GrupoModel grupo;
  final int idPedido;
  final int tipoProduto;

  UpdateGrupo({
    required this.grupo,
    required this.idPedido,
    required this.tipoProduto,
  });
}

class DeleteGrupo extends GrupoEvent {
  final GrupoModel grupo;

  DeleteGrupo({required this.grupo});
}
