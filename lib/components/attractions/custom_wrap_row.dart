import 'package:flutter/material.dart';

class CustomWrapRow extends StatefulWidget {
  final List contents;
  final Function(dynamic) getResultsFromUser;
  final bool isReset;
  const CustomWrapRow({
    super.key,
    required this.contents,
    required this.getResultsFromUser,
    required this.isReset,
  });

  @override
  State<CustomWrapRow> createState() => _CustomWrapRowState();
}

class _CustomWrapRowState extends State<CustomWrapRow> {
  List items = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [];
    int count = 0;

    // reset
    if (widget.isReset) {
      if (items.isNotEmpty) {
        items.forEach((element) {
          element[1]['isSelected'] = false;
        });
      }
    }

    for (var item in widget.contents) {
      var index = count;

      String rangePrice;
      String rangePriceNoAmount;
      var fromPrice = 'VND ${item['from']}';
      var toPriceNoAmount = ' - VND ${item['to']}';
      String toPrice;

      if (item['to'] != null) {
        toPrice = '$toPriceNoAmount (${item['amount']})';
      } else {
        toPrice = ' (${item['amount']})';
      }
      rangePriceNoAmount = fromPrice + toPriceNoAmount;
      rangePrice = fromPrice + toPrice;

      var element = [
        {'content': rangePriceNoAmount, 'amount': item['amount']},
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
            rangePrice,
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
      // print(items);

    return Wrap(
      children: elements,
    );
  }
}
