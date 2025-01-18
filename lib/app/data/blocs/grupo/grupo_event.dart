import 'package:sgc/app/models/group_model.dart';

abstract class GrupoEvent {}

class GetGrupo extends GrupoEvent {
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  GetGrupo({
    required this.idPedido,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
  });
}

class PostGrupo extends GrupoEvent {
  final GrupoModel grupo;

  PostGrupo({required this.grupo});
}

class UpdateGrupo extends GrupoEvent {
  final GrupoModel grupo;
  final int idPedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;

  UpdateGrupo({
    required this.grupo,
    required this.idPedido,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
  });
}

class DeleteGrupo extends GrupoEvent {
  final GrupoModel grupo;

  DeleteGrupo({required this.grupo});
}
