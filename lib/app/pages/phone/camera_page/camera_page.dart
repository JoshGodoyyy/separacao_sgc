import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/repositories/foto_pedido.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import 'package:sgc/app/pages/phone/fotos_page/widgets/modal_foto.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'dart:io';
import 'package:sgc/app/ui/widgets/error_alert.dart';

import '../../../data/enums/icones.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final FotoPedidoModel fotoPedido;

  const CameraPage({
    super.key,
    required this.camera,
    required this.fotoPedido,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  Future<String> imageToBase64(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _controller,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Material(
        shape: const CircleBorder(),
        color: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Material(
            shape: const CircleBorder(),
            color: Colors.white,
            child: InkWell(
              onTap: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  final base64String = await imageToBase64(image.path);

                  FotoPedidoModel foto = widget.fotoPedido;
                  foto.imagem = image.path;

                  if (!mounted) return;
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPicture(
                            imageBase64: base64String,
                            fotoPedido: foto,
                          ),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  ErrorAlert(
                    message: e.toString(),
                  );
                }
              },
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DisplayPicture extends StatefulWidget {
  final String imageBase64;
  final FotoPedidoModel fotoPedido;

  const DisplayPicture({
    super.key,
    required this.imageBase64,
    required this.fotoPedido,
  });

  @override
  State<DisplayPicture> createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  final DateFormat _data = DateFormat('yyyy-MM-dd');
  final tituloController = TextEditingController();

  _title() => tituloController.text == ''
      ? '${_data.format(DateTime.now())}_SGC_Image'
      : tituloController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title()),
        actions: [
          IconButton(
            onPressed: () {
              tituloController.text = _title();
              showModal(
                context,
                tituloController,
                () {
                  setState(() {});
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Image.file(
        File(widget.fotoPedido.imagem ?? ''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FotoPedidoModel foto = widget.fotoPedido;
          foto.descricao = tituloController.text == ''
              ? '${_data.format(DateTime.now())}_SGC_Image'
              : tituloController.text;
          foto.imagem = widget.imageBase64;

          foto.dataFoto = _data.format(
            DateTime.now(),
          );

          await FotoPedido().insert(
            foto,
          );

          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    titulo: 'SGC Mobile',
                    conteudo: Text('Foto salva com sucesso'),
                    tipo: Icones.info,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
