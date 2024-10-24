import 'package:flutter/material.dart';
import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  int _seconds = 0;
  bool _running = false;
  Timer? _timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _running = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _running = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
    });
  }

  String _formatSeconds(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove the default AppBar height
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Set height to 0
        child: Container(
          color: Colors.transparent, // Make the app bar transparent
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  _controller.value * 0.5,
                  _controller.value,
                ],
                colors: const [Color(0xFF0077B6), Color(0xFF000000)],
              ),
            ),
            child: SafeArea(
              // Ensure content is not obscured by system UI
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Use a container for custom back button
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigates back to the previous screen
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/128/4283/4283987.png',
                    height: 150,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _formatSeconds(_seconds),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCustomButton(
                        label: 'Start',
                        onPressed: _running ? null : _startTimer,
                      ),
                      const SizedBox(width: 10),
                      _buildCustomButton(
                        label: 'Stop',
                        onPressed: _running ? _stopTimer : null,
                      ),
                      const SizedBox(width: 10),
                      _buildCustomButton(
                        label: 'Reset',
                        onPressed: _resetTimer,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomButton({required String label, VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
