import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SadhanaSessionScreen extends StatefulWidget {
  final String deityName;
  final String deityImage;
  final String mantraAudio;
  final String mantraText;

  const SadhanaSessionScreen({
    super.key,
    required this.deityName,
    required this.deityImage,
    required this.mantraAudio,
    required this.mantraText,
  });

  @override
  State<SadhanaSessionScreen> createState() => _SadhanaSessionScreenState();
}

class _SadhanaSessionScreenState extends State<SadhanaSessionScreen> {
  int _counter = 0;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _showMantra = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioListeners();
  }

  void _setupAudioListeners() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
        _showMantra = _isPlaying;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _showMantra = false;
        _counter++;
      });

      if (_counter == 108) {
        _showCompletionDialog();
      }
    });
  }

  Future<void> _playMantra() async {
    if (_isPlaying) return;

    try {
      await _audioPlayer.play(AssetSource('audio/${widget.mantraAudio}'));
    } catch (e) {
      debugPrint('Audio error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error playing mantra'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sadhana Complete!'),
        content: Text('Completed 108 chants of ${widget.deityName}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deityName),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.deityImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Mantra at feet during chanting
          if (_showMantra)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Text(
                widget.mantraText,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_counter / 108',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _playMantra,
                    child: Text(
                      _isPlaying ? 'Chanting...' : 'Chant Mantra',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
