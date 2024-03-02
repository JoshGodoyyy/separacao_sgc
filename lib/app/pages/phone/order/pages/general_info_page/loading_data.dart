import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

class LoadingData extends StatefulWidget {
  const LoadingData({super.key});

  @override
  State<LoadingData> createState() => _LoadingDataState();
}

class _LoadingDataState extends State<LoadingData> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ItemSkeleton(
                label: 'Criado por:',
              ),
            ),
            Flexible(
              flex: 2,
              child: ItemSkeleton(
                label: 'Data de Criação:',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ItemSkeleton(
                label: 'ID Cliente:',
              ),
            ),
            Flexible(
              flex: 2,
              child: ItemSkeleton(
                label: 'Razão Social:',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ItemSkeleton(
                label: 'ID Vendedor:',
              ),
            ),
            Flexible(
              flex: 2,
              child: ItemSkeleton(
                label: 'Vendedor:',
              ),
            ),
          ],
        ),
        ItemSkeleton(
          label: 'Endereço:',
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ItemSkeleton(
                label: 'Número:',
              ),
            ),
            Flexible(
              flex: 2,
              child: ItemSkeleton(
                label: 'Complemento:',
              ),
            ),
          ],
        ),
        ItemSkeleton(
          label: 'Bairro:',
        ),
        ItemSkeleton(
          label: 'Cidade:',
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ItemSkeleton(
                label: 'Estado:',
              ),
            ),
            Flexible(
              flex: 2,
              child: ItemSkeleton(
                label: 'CEP:',
              ),
            ),
          ],
        ),
        ItemSkeleton(
          label: 'Data e Hora de Entrega:',
        ),
        ItemSkeleton(
          label: 'Tipo de Entrega:',
        ),
        Row(
          children: [
            Expanded(
              child: ItemSkeleton(
                label: 'NFe Venda:',
              ),
            ),
            Expanded(
              child: ItemSkeleton(
                label: 'NFe Remessa:',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemSkeleton extends StatefulWidget {
  final String label;
  const ItemSkeleton({
    super.key,
    required this.label,
  });

  @override
  State<ItemSkeleton> createState() => _ItemSkeletonState();
}

class _ItemSkeletonState extends State<ItemSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LoadingAnimationWidget.stretchedDots(
                    color: ColorsApp.secondaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
