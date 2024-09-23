import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'new_task_page.dart'; // Import halaman NewTaskPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now(); // Tanggal awal di-set ke hari ini
  final PageController _pageController = PageController(initialPage: 500);
  DateTime currentMonthYear = DateTime.now(); // Bulan dan tahun saat ini

  // Fungsi untuk mendapatkan tanggal minggu berdasarkan offset
  List<DateTime> getWeekDates(DateTime referenceDate, int offsetWeeks) {
    DateTime currentDate = referenceDate.add(Duration(days: offsetWeeks * 7));
    DateTime startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // Fungsi untuk format bulan dan tahun di AppBar
  String formatMonthYear(DateTime date) {
    DateTime today = DateTime.now();
    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return 'Today'; // Tampilkan "Today" jika tanggal adalah hari ini
    }
    return DateFormat('MMMM yyyy')
        .format(date); // Format bulan dan tahun lainnya
  }

  // Fungsi untuk mendapatkan bulan dan tahun dari tanggal pertama di minggu
  void updateCurrentMonthYear(int weekOffset) {
    List<DateTime> weekDates = getWeekDates(DateTime.now(), weekOffset);
    setState(() {
      currentMonthYear = weekDates.first; // Ambil tanggal pertama dari minggu
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(195, 103, 175, 1),
        centerTitle: true,
        title: Text(
          formatMonthYear(selectedDate), // Tampilkan "Today" atau bulan & tahun
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Swipe horizontal PageView untuk minggu
          Container(
            height: 100,
            color: const Color.fromRGBO(195, 103, 175, 1),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                int weekOffset = index - 500;
                updateCurrentMonthYear(
                    weekOffset); // Update bulan dan tahun saat swipe
              },
              itemBuilder: (context, index) {
                int weekOffset = index - 500;
                List<DateTime> weekDates =
                    getWeekDates(DateTime.now(), weekOffset);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: weekDates.map((date) {
                    bool isSelected = selectedDate.day == date.day &&
                        selectedDate.month == date.month &&
                        selectedDate.year == date.year;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date; // Update tanggal yang dipilih
                          currentMonthYear = date; // Sinkronkan bulan & tahun
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            DateFormat('E').format(date), // Menampilkan hari
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromRGBO(171, 25, 140, 1)
                                  : Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tambahkan Ilustrasi
                  Image.asset(
                    'assets/images/gambar_hal1.png', // Ganti dengan path gambar ilustrasi
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No tasks yet.\nTap '+' to start schedule planning",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: FloatingActionButton(
              onPressed: () {
                // Navigasi ke halaman NewTaskPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTaskPage(
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            onNewTask: (String, DateTime, TimeOfDay) {},
                          )),
                );
              },
              backgroundColor: const Color.fromRGBO(195, 103, 175, 1),
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
