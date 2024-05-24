import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class CustomizePrice extends StatefulWidget {
  const CustomizePrice({super.key});

  @override
  State<CustomizePrice> createState() => _CustomizePriceState();
}

class _CustomizePriceState extends State<CustomizePrice> {
  int startPrice = 100000;
  int endPrice = 4000000;
  RangeValues currentRangeValues = const RangeValues(0, 100);

  int scalePrice(double price) {
    var scaledPrice =
        (((4000000 - 100000) * (price / 100)) + 100000).floor();
    return scaledPrice;
  }

  String formatPrice(int price) {
    var formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ngân sách của bạn (cho 1 đêm)',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'VND ${formatPrice(startPrice)} - VND ${formatPrice(endPrice)} ${endPrice == 4000000 ? '+' : ''}',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),

        // range slider
        RangeSlider(
          values: currentRangeValues,
          max: 100,
          divisions: 100,
          onChanged: (RangeValues values) {
            setState(() {
              currentRangeValues = values;
              startPrice = scalePrice(values.start);
              endPrice = scalePrice(values.end);
            });
          },
        )
      ],
    );
  }
}
