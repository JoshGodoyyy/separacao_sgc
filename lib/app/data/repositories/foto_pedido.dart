import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';

class FotoPedido {
  final String _url = '${ApiConfig().url}/OrderPhoto';

  Future<List<dynamic>> fetchFotosSeparacao(int idPedido) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosOnSeparation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idPedido),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosSeparacaoCarregamento(
    int idRoteiro,
    int idCliente,
  ) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosSeparationFromLoading'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'idRoteiroEntrega': idRoteiro,
        'idCliente': idCliente,
      }),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosSeparacaoCarregado(
    int idRoteiro,
  ) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosSeparationFromLoaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        idRoteiro,
      ),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosConferencia(int idPedido) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosOnConference'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idPedido),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosConferenciaCarregamento(
    int idRoteiro,
    int idCliente,
  ) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosConferenceFromLoading'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'idRoteiroEntrega': idRoteiro,
        'idCliente': idCliente,
      }),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosConferenciaCarregado(
    int idRoteiro,
  ) async {
    var response =
        await http.post(Uri.parse('$_url/GetPhotosConferenceFromLoaded'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
              idRoteiro,
            ));

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosCarregando(FotoPedidoModel foto) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosOnLoading'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': int.parse(foto.id.toString()),
        'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
        'idPedido': int.parse(foto.idPedido.toString()),
        'idCliente': int.parse(foto.idCliente.toString()),
        'idRoteiro': int.parse(foto.idRoteiro.toString()),
        'imagem': '',
        'descricao': '',
        'dataFoto': ''
      }),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchAllFotosCarregando(int idRoteiro) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosOnLoadingFromLoaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idRoteiro),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosCarregado(int idRoteiro) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosLoaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idRoteiro),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> fetchFotosEntregue(int idRoteiro) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotosDelivered'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idRoteiro),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future insert(FotoPedidoModel foto) async {
    await http.post(
      Uri.parse('$_url/InsertPhoto'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': int.parse(foto.id.toString()),
          'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
          'idPedido': int.parse(foto.idPedido.toString()),
          'idRoteiro': int.parse(foto.idRoteiro.toString()),
          'imagem': foto.imagem,
          'descricao': foto.descricao,
          'dataFoto': foto.dataFoto,
        },
      ),
    );
  }

  Future<void> delete(FotoPedidoModel foto) async {
    await http.delete(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': int.parse(foto.id.toString()),
          'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
          'idPedido': int.parse(foto.idPedido.toString()),
          'idRoteiro': int.parse(foto.idRoteiro.toString()),
          'imagem': foto.imagem,
          'descricao': foto.descricao,
          'dataFoto': foto.dataFoto,
        },
      ),
    );
  }
}
