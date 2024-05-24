import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Field extends StatefulWidget {
  final Map field;
  final Function setValue;
  final bool checkError;
  const Field(
      {super.key,
      required this.field,
      required this.setValue,
      required this.checkError});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  String input = '';
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.field['label']}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                '*',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                input = value;
              });
              widget.setValue(widget.field['value'], value);
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: widget.checkError == true && input.isEmpty,
            child: const Text(
              'Vui lòng không để trống!',
              style: TextStyle(fontSize: 17, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
