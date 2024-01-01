import '../../../models/embalagem_model.dart';

abstract class EmbalagemEvent {}

class GetEmbalagens extends EmbalagemEvent {
  final int idPedido;

  GetEmbalagens({required this.idPedido});
}

class PostEmbalagem extends EmbalagemEvent {
  final EmbalagemModel embalagem;

  PostEmbalagem({required this.embalagem});
}

class UpdateEmbalagem extends EmbalagemEvent {
  final EmbalagemModel embalagem;

  UpdateEmbalagem({required this.embalagem});
}

class DeleteEmbalagem extends EmbalagemEvent {
  final EmbalagemModel embalagem;

  DeleteEmbalagem({required this.embalagem});
}
