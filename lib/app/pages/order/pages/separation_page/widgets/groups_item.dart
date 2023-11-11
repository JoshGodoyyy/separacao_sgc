import 'package:flutter/material.dart';
import 'package:sgc/app/models/group_model.dart';

class GroupItem extends StatelessWidget {
  final GroupModel item;
  final Function onTap;
  const GroupItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.descricao.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text('Grupo: ${item.id}'),
                      Text('Peso Teórico: ${item.pesoTeorico}'),
                      Text('Peso Real: ${item.pesoReal}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: item.separar, onChanged: (value) {}),
                    const Text('Separar'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
