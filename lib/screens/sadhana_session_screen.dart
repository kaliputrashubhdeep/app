import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SadhanaSessionScreen extends StatefulWidget {
  final String deityName;
  final String deityImage;
  final String mantraAudio;

  const SadhanaSessionScreen({
    super.key,
    required this.deityName,
    required this.deityImage,
    required this.mantraAudio,
  });

  @override
  State<SadhanaSessionScreen> createState() => _SadhanaSessionScreenState();
}

class _SadhanaSessionScreenState extends State<SadhanaSessionScreen> {
  int _counter = 0;
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isCompleted = false;
  final bool _isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() => _isPlaying = false);
    });
  }

  Future<void> _chantMantra() async {
    if (_counter >= 108 || _isPlaying) return;

    try {
      setState(() => _isPlaying = true);

      await _audioPlayer.play(
        AssetSource('audio/${widget.mantraAudio}'),
        volume: 1.0,
      );

      setState(() {
        _counter++;
        if (_counter == 108) {
          _isCompleted = true;
          _showCompletionDialog();
        }
      });
    } catch (e) {
      debugPrint('Audio Error: $e');
      setState(() => _isPlaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error playing mantra audio'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Sadhana Complete!',
          style: TextStyle(color: Colors.orange),
        ),
        content: Text(
          'You have completed 108 chants of ${widget.deityName}.',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Jai Bhairav!',
              style: TextStyle(color: Colors.orange),
            ),
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
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              widget.deityImage,
              fit: BoxFit.cover,
              width: double.infinity,
              frameBuilder: (context, child, frame, _) {
                if (frame == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return child;
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chants Completed',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_counter / 108',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isPlaying || _isCompleted ? null : _chantMantra,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      _isPlaying
                          ? 'Chanting...'
                          : _isCompleted
                              ? 'Completed!'
                              : 'Chant Mantra',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  if (_isPlaying) const SizedBox(height: 20),
                  if (_isPlaying)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
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
