import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'new_task_page.dart'; // halaman buat reminder baru

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now(); // tanggal default hari ini
  Map<String, List<String>> tasks = {}; // menyimpan pengingat tiap tanggal

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: Colors.pink[300],
      ),
      body: Column(
        children: [
          // Calendar Date Picker
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // 7 hari dalam seminggu
              itemBuilder: (context, index) {
                DateTime currentDate =
                    DateTime.now().add(Duration(days: index));
                bool isSelected = selectedDate.day == currentDate.day;

                return GestureDetector(
                  onTap: () => _onDateSelected(currentDate),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pink[300] : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('E').format(currentDate)),
                        Text(DateFormat('d').format(currentDate)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: tasks[DateFormat('yyyy-MM-dd').format(selectedDate)] == null
                ? const Center(
                    child: Text(
                      'No tasks yet.\nTap "+" to start schedule planning',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        tasks[DateFormat('yyyy-MM-dd').format(selectedDate)]!
                            .length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[DateFormat('yyyy-MM-dd')
                            .format(selectedDate)]![index]),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTaskPage()),
          );
          if (newTask != null) {
            setState(() {
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
              if (tasks[formattedDate] == null) {
                tasks[formattedDate] = [];
              }
              tasks[formattedDate]!.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
