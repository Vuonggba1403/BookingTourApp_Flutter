import 'package:flutter/material.dart';

class WrapRow extends StatefulWidget {
  final List contents;
  final Function(dynamic) getResultsFromUser;
  final bool isReset;
  const WrapRow({
    super.key,
    required this.contents,
    required this.getResultsFromUser,
    required this.isReset,
  });

  @override
  State<WrapRow> createState() => _WrapRowState();
}

class _WrapRowState extends State<WrapRow> {
  List items = [];

  void removeItem(List items) {
    for (var item in items) {
      item[1]['isSelected'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [];
    int count = 0;

    if (widget.isReset) {
      if (items.isNotEmpty) {
        removeItem(items);
      }
    }

    for (var item in widget.contents) {
      var index = count;
      var element = [
        item,
        {'isSelected': false}
      ];

      setState(() {
        items.add(element);
      });

      elements.add(GestureDetector(
        onTap: () {
          setState(() {
            items[index][1]['isSelected'] = !items[index][1]['isSelected'];
          });
          widget.getResultsFromUser(items[index]);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.fromLTRB(0, 8, 10, 8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: items[index][1]['isSelected']
                      ? const Color.fromARGB(255, 0, 108, 228)
                      : const Color.fromARGB(255, 133, 133, 133)),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            item.values.elementAt(0) +
                ' (' +
                item.values.elementAt(1).toString() +
                ')',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: items[index][1]['isSelected']
                    ? const Color.fromARGB(255, 0, 108, 228)
                    : const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ));

      count++;
    }

    return Wrap(
      children: elements,
    );
  }
}
