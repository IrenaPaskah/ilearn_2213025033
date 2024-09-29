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
  List<Map<String, dynamic>> tasks = []; // Daftar tugas

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

  // Fungsi untuk menambahkan tugas baru
  void _addTask(String taskName, DateTime date, TimeOfDay? time) {
    setState(() {
      tasks.add({
        'name': taskName,
        'date': date,
        'time': time,
      }); // Tambahkan tugas ke daftar
      selectedDate = date; // Update tanggal yang dipilih
      currentMonthYear = date; // Sinkronkan bulan & tahun
    });
  }

  // Fungsi untuk memilih tanggal dari dialog date picker
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        currentMonthYear =
            picked; // Update bulan dan tahun sesuai tanggal yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(195, 103, 175, 1),
        centerTitle: true,
        title: GestureDetector(
          onTap: _selectDate, // Memungkinkan pemilihan tanggal saat mengetuk
          child: Text(
            formatMonthYear(
                currentMonthYear), // Tampilkan "Today" atau bulan & tahun
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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

          // Bagian menampilkan tugas
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                  )
                : ListView.builder(
                    // Filter tugas berdasarkan tanggal yang dipilih
                    itemCount: tasks.where((task) {
                      DateTime taskDate = task['date'];
                      return taskDate.day == selectedDate.day &&
                          taskDate.month == selectedDate.month &&
                          taskDate.year == selectedDate.year;
                    }).length,
                    itemBuilder: (context, index) {
                      // Ambil tugas yang sudah difilter
                      var filteredTasks = tasks.where((task) {
                        DateTime taskDate = task['date'];
                        return taskDate.day == selectedDate.day &&
                            taskDate.month == selectedDate.month &&
                            taskDate.year == selectedDate.year;
                      }).toList();

                      // Tampilkan tugas berdasarkan index dari filteredTasks
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          title: Text(
                            filteredTasks[index]['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(171, 25, 140, 1),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                'Date: ${DateFormat.yMMMMd().format(filteredTasks[index]['date'])}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              if (filteredTasks[index]['time'] != null)
                                Text(
                                  'Time: ${filteredTasks[index]['time'].format(context)}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                tasks.remove(filteredTasks[
                                    index]); // Hapus task dari daftar
                              });
                            },
                          ),
                        ),
                      );
                    },
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
                            onNewTask: _addTask,
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
