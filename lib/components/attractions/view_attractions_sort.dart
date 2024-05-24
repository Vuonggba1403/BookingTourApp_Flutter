import 'package:flutter/material.dart';

class ViewAttractionsSort extends StatefulWidget {
  final int currentOptionSort;
  const ViewAttractionsSort({super.key, required this.currentOptionSort});

  @override
  State<ViewAttractionsSort> createState() => _ViewAttractionsSortState();
}

class _ViewAttractionsSortState extends State<ViewAttractionsSort> {
  int selectedOption = 0;

  // set the option as the user's previous option
  @override
  void initState() {
    super.initState();
    setOption();
  }

  setOption() {
    setState(() {
      selectedOption = widget.currentOptionSort;
    });
  }

  getOptions(option) {

    option == null ? option = 0 :

    setState(() {
      selectedOption = option;
    });
    Navigator.pop(context, option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // divider
            Center(
              child: Container(
                width: 80,
                height: 5,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 113, 113, 113),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),

            const SizedBox(height: 15),

            // options sort
            const Text(
              "Sắp xếp theo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 15),

            // suggestions of system
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Đề xuất của chúng tôi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Radio<int>(
                    value: 0,
                    groupValue: selectedOption,
                    onChanged: (value) => getOptions(value))
              ],
            ),

            const SizedBox(height: 15),

            // most popular
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Được ưa chuộng nhất',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Radio<int>(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) => getOptions(value))
              ],
            ),

            const SizedBox(height: 15),

            // the cheapest
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Giá thấp nhất',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Radio<int>(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) => getOptions(value))
              ],
            )
          ],
        ),
      ),
    );
  }
}
