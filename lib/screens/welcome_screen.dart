import 'package:flutter/material.dart';
import 'deity_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/maha.jpg', height: 200),
            const SizedBox(height: 30),
            const Text(
              'Salutations to Praveen Radhakrishanan\nmy guru who is none other than\nMaa Adya Mahakaali',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepOrange,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bhairava Kalike Namastute',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeitySelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text(
                'Begin Sadhana',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
