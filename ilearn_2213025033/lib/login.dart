import 'package:flutter/material.dart';

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
                        height: 200), // Add your image here
                    const SizedBox(height: 20),
                    const Text(
                      'No tasks yet.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(129, 120, 120, 1)),
                    ),
                    const Text(
                      'Tap "+" to start schedule planning',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(129, 120, 120, 1)),
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
                  // Add task logic
                },
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
      decoration: BoxDecoration(
        color: Colors.purple[200],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
        Text(day, style: const TextStyle(color: Colors.black)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.purple, width: 2),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
