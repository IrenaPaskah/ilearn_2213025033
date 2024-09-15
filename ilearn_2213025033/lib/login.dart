import 'package:flutter/material.dart'; // Pastikan ini digunakan
import 'logo.dart'; // Logo digunakan di dalam build, jadi tetap dibiarkan

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns labels to the left
          children: [
            const Center(child: LogoWidget()), // Centering the logo widget
            const SizedBox(height: 50),

            // Username Label
            const Text(
              'Username*',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 18),

            // Username Input Field
            TextField(
              decoration: InputDecoration(
                hintText:
                    'Student ID', // Changed to hintText to avoid unnecessary warnings
                fillColor: const Color.fromRGBO(255, 204, 0, 0.53),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 34),

            // Password Label
            const Text(
              'Password*',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 18),

            // Password Input Field
            TextField(
              obscureText: true, // Hides the password input
              decoration: InputDecoration(
                hintText: 'Enter your password',
                fillColor: const Color.fromRGBO(255, 204, 0, 0.53),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 34),

            // Login Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic for login action
                  // Ensure you define onPressed logic, even if it’s an empty function
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(124, 147, 195,
                      0.47), // Updated to `backgroundColor` to avoid deprecation warnings
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 34),

            // Forgot Password Linkeu
            Center(
              child: GestureDetector(
                onTap: () {
                  // Logic for forgot password action
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
