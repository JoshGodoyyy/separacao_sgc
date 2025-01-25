import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';

class VisualizarFoto extends StatelessWidget {
  final FotoPedidoModel foto;
  const VisualizarFoto({
    super.key,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${foto.descricao}'),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(12),
          minScale: 0.5,
          maxScale: 10,
          child: Image.memory(
            base64Decode(foto.imagem!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
