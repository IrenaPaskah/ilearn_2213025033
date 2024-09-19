import 'package:flutter/material.dart';

import 'newtask.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calendar and Today's Date Section
            _buildCalendarSection(),

            // Image or Illustration
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gambar_hal1.png',
                        height: 212), // Add your image here
                    const SizedBox(height: 20),
                    const Text(
                      'No tasks yet.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(129, 120, 120, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Tap "+" to start schedule planning',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(129, 120, 120, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Floating action button (plus button)
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  //Pindah ke halaman New Task saat tombol + dipencet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewTaskPage()),
                  );
                },
                // Add task logic
                backgroundColor: const Color.fromRGBO(195, 103, 175, 1),
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(195, 103, 175, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          const SizedBox(height: 10),
          _buildCalendarRow(),
        ],
      ),
    );
  }

  Widget _buildCalendarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDay('Su', '15'),
        _buildDay('Mo', '16', isSelected: true),
        _buildDay('Tu', '17'),
        _buildDay('We', '18'),
        _buildDay('Th', '19'),
        _buildDay('Fr', '20'),
        _buildDay('Sa', '21'),
      ],
    );
  }

  Widget _buildDay(String day, String date, {bool isSelected = false}) {
    return Column(
      children: [
        Text(day, style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(171, 25, 140, 1)
                : const Color.fromRGBO(255, 255, 255, 1),
            shape: BoxShape.circle,
            border: Border.all(
                color: const Color.fromRGBO(175, 25, 140, 1), width: 2),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            date,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
