import 'package:flutter/material.dart';
import 'package:sgc/app/models/group_model.dart';

import 'groups_item.dart';

class Groups extends StatefulWidget {
  final List<GroupModel> groups;
  final BuildContext context;
  const Groups({
    super.key,
    required this.groups,
    required this.context,
  });

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (var group in widget.groups)
            GroupItem(
              item: group,
              onTap: () {
                _showDialog(context, group).then((value) => setState(() {}));
              },
            ),
        ],
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context, GroupModel group) async {
  final pesoRealController = TextEditingController();
  bool separar = false;

  pesoRealController.text = group.pesoReal.toString();
  separar = group.separar;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Peso real'),
                TextField(
                  controller: pesoRealController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: separar,
                      onChanged: (bool? value) =>
                          setState(() => separar = value!),
                    ),
                    const Text('Separar'),
                  ],
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              group.pesoReal = double.parse(pesoRealController.text);
              group.separar = separar;
              Navigator.of(context).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
