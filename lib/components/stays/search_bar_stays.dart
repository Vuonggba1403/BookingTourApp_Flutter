import 'package:BookingTourApp/Screens/Other_Page/attractions/search_attractions.dart';
import 'package:BookingTourApp/Screens/Other_Page/stays/view_stays.dart';
import 'package:BookingTourApp/components/stays/select_type_of_rooms.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchBarStays extends StatefulWidget {
  const SearchBarStays({super.key});

  @override
  State<SearchBarStays> createState() => _SearchBarStaysState();
}

class _SearchBarStaysState extends State<SearchBarStays> {
  @override
  void initState() {
    super.initState();
    getCurrenDate();
  }

  String input = '';
  String selectedDate = '';
  List typeOfRooms = [1,2,0];
  bool showPickerDate = false;

  void getCurrenDate() {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    DateTime nextDate = DateTime(now.year, now.month, now.day + 1);

    setState(() {
      selectedDate = '${formatDate(currentDate)} - ${formatDate(nextDate)}';
    });
  }

  Future<void> _navigateToSearchAttractions(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchAttractions()),
    );

    if (!context.mounted) return;

    if (result.toString().isNotEmpty) {
      setState(() {
        input = result;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTimeRange? userSelectedDate = await showDateRangePicker(
      context: context,
      firstDate: DateTime(currentDate.year, currentDate.month),
      currentDate: DateTime.now(),
      lastDate: DateTime(currentDate.year + 1, 12),
    );

    if (userSelectedDate != null) {
      // format for selected date
      var startDate = formatDate(userSelectedDate.start);
      var endDate = formatDate(userSelectedDate.end);

      // show selected date in search bar
      setState(() {
        selectedDate = '$startDate - $endDate';
      });
    }
  }

  String formatDate(DateTime date) {
    String formatedDate = DateFormat('dd/MM/yyyy').format(date);
    return formatedDate.toString();
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
                        input != '' ? input : "Bạn muốn ở đâu?",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                        selectedDate,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // select the type of room
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) => SelectTypeOfRooms(
                            previousOptions: typeOfRooms,
                          )).then((value) {
                    if (value != null) {
                      setState(() {
                        typeOfRooms = value;
                      });
                    }
                  });
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
                        Icons.person,
                        size: 25,
                        color: Color.fromARGB(255, 84, 84, 84),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '${typeOfRooms[0]} phòng . ${typeOfRooms[1]} người lớn . ${typeOfRooms[2]} trẻ em',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                      if (input.isNotEmpty &&
                          selectedDate.isNotEmpty &&
                          typeOfRooms.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewStays(
                                      input: [input, selectedDate],
                                    )));
                      }
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
                        )))),
          ],
        ),
      ),
    );
  }
}
