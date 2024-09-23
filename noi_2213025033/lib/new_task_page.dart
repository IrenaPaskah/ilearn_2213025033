import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatefulWidget {
  final Function(String, DateTime, TimeOfDay?) onNewTask;

  const NewTaskPage({super.key, required this.onNewTask});

  @override
  // ignore: library_private_types_in_public_api
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Tanggal pengingat
  TimeOfDay? selectedTime; // Waktu pengingat

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // Menyimpan task baru
  void _saveTask() {
    if (_taskController.text.isNotEmpty) {
      widget.onNewTask(_taskController.text, selectedDate, selectedTime);
      Navigator.pop(context); // Kembali ke HomePage setelah menyimpan
    }
  }

  // Pemilihan tanggal pengingat
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Pemilihan waktu pengingat
  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create Task'),
        actions: [
          TextButton(
            onPressed: _saveTask, // Simpan task ketika tombol "Create" diklik
            child: const Text(
              'Create',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ilustrasi gambar di bagian atas
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/newtaskimage.png', // Ganti dengan path gambar yang sesuai
                height: 150,
              ),
            ),
            // Input judul Task
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'New Task (tap to rename)',
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLength: 50, // Maksimal 50 karakter
              textAlign: TextAlign.center, //posisi tengah
            ),

            const SizedBox(height: 20),
            // Pilihan Tanggal Pengingat
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == DateTime.now()
                          ? 'Today'
                          : DateFormat.yMMMd().format(selectedDate),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Pilihan Waktu Pengingat
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime == null
                          ? 'No reminder'
                          : selectedTime!.format(context),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Icon(Icons.access_time),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
