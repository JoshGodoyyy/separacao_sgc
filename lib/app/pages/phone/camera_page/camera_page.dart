import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/data/repositories/foto_pedido.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import 'package:sgc/app/pages/phone/fotos_page/widgets/modal_foto.dart';
import 'dart:io';
import 'package:sgc/app/ui/widgets/error_alert.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final int idPedido;
  final SituacaoFoto situacaoFoto;
  final int idRoteiro;
  final int idCliente;

  const CameraPage({
    super.key,
    required this.camera,
    required this.idPedido,
    required this.situacaoFoto,
    required this.idRoteiro,
    required this.idCliente,
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

                  if (!mounted) return;
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPicture(
                            imagePath: image.path,
                            idPedido: widget.idPedido,
                            situacaoFoto: widget.situacaoFoto,
                            imageBase64: base64String,
                            idRoteiro: widget.idRoteiro,
                            idCliente: widget.idCliente,
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
  final String imagePath;
  final int idPedido;
  final SituacaoFoto situacaoFoto;
  final String imageBase64;
  final int idRoteiro;
  final int idCliente;

  const DisplayPicture({
    super.key,
    required this.imagePath,
    required this.idPedido,
    required this.situacaoFoto,
    required this.imageBase64,
    required this.idRoteiro,
    required this.idCliente,
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
        File(widget.imagePath),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FotoPedido().insert(
            FotoPedidoModel(
              0,
              widget.situacaoFoto.index,
              widget.idPedido,
              widget.idRoteiro,
              widget.idCliente,
              widget.imageBase64,
              tituloController.text == ''
                  ? '${_data.format(DateTime.now())}_SGC_Image'
                  : tituloController.text,
              _data.format(
                DateTime.now(),
              ),
            ),
          );

          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pop(context);
            },
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
