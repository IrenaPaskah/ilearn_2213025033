import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 203, 235, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () {
            // Kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Logic untuk create task
            },
            child: const Text(
              'Create',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            // Ilustrasi gambar task
            Center(
              child: Image.asset('assets/images/newtaskimage.png',
                  height: 140), // Gambar task icon
            ),

            const SizedBox(height: 40),

            // Teks "New Task"
            const Text(
              'New Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Teks "Tap to rename"
            const Text(
              'Tap to rename',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(11, 11, 11, 0.511),
              ),
            ),

            const SizedBox(height: 40),

            // Kotak "Today" dan "No Reminder"
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(238, 238, 238, 1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Column(
                children: [
                  // Pilih Tanggal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today', style: TextStyle(fontSize: 20)),
                      Icon(Icons.calendar_today, color: Colors.black),
                    ],
                  ),
                  Divider(),
                  // Pilih Reminder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No reminder', style: TextStyle(fontSize: 20)),
                      Icon(Icons.alarm, color: Color.fromRGBO(0, 0, 0, 1)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor:
          const Color.fromRGBO(244, 203, 235, 1), // Background warna pink muda
    );
  }
}
