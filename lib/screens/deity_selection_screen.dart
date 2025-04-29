import 'package:flutter/material.dart';
import 'sadhana_session_screen.dart';

class DeitySelectionScreen extends StatelessWidget {
  DeitySelectionScreen({super.key}); // Removed const constructor

  // Made the list final but not const
  final List<Map<String, String>> deities = [
    {
      'name': 'Batuk Bhairav',
      'image': 'assets/images/batuk.jpg',
      'audio': 'batuk.mp3',
    },
    {
      'name': 'Swarnaakarshana Bhairav',
      'image': 'assets/images/swarna.jpg',
      'audio': 'swarna.mp3',
    },
    {
      'name': 'Skanda Bhairav',
      'image': 'assets/images/skanda.jpg',
      'audio': 'skanda.mp3',
    },
    {
      'name': 'Maha Bhairav',
      'image': 'assets/images/maha.jpg',
      'audio': 'maha.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2),
        children: deities.map((deity) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SadhanaSessionScreen(
                    deityName: deity['name']!,
                    deityImage: deity['image']!,
                    mantraAudio: deity['audio']!,
                  ),
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  deity['image']!,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    deity['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
