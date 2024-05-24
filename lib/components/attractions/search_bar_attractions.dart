import 'package:BookingTourApp/Screens/Other_Page/attractions/search_attractions.dart';
import 'package:BookingTourApp/Screens/Other_Page/attractions/view_attractions.dart';
import 'package:flutter/material.dart';

class SearchBarAttractions extends StatefulWidget {
  const SearchBarAttractions({super.key});

  @override
  State<SearchBarAttractions> createState() => _SearchBarAttractionsState();
}

class _SearchBarAttractionsState extends State<SearchBarAttractions> {
  String input = '';
  String selectedDate = '';

  Future<void> _navigateToSearchAttractions(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchAttractions()),
    );

    if (!context.mounted) return;

    if (result != '') {
      setState(() {
        input = result;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));

    if (userSelectedDate != null) {
      setState(() {
        selectedDate = userSelectedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: const Color.fromARGB(255, 238, 155, 77),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // select attractions
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => {_navigateToSearchAttractions(context)},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 19.0, vertical: 11.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 4,
                    color: Color.fromARGB(255, 238, 155, 77),
                  ))),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 25,
                        color: Color.fromARGB(255, 84, 84, 84),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        maxLines: 1,
                        softWrap: true,
                        input != '' ? input : "Bạn muốn đi đâu?",
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ),

            // select date
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 19.0, vertical: 11.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 4,
                    color: Color.fromARGB(255, 238, 155, 77),
                  ))),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 25,
                        color: Color.fromARGB(255, 84, 84, 84),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        selectedDate != '' ? selectedDate : "Bất cứ ngày nào",
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewAttractions()));
                    },
                    child: Container(
                        width: double.infinity,
                        color: const Color.fromARGB(255, 0, 108, 228),
                        child: const Center(
                          child: Text(
                            'Tìm',
                            style: TextStyle(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 108, 228),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ))))
          ],
        ),
      ),
    );
  }
}
