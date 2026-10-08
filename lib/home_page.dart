import 'dart:isolate';
import 'package:flutter/material.dart';
import 'prime_counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _status = 'Vyberte způsob výpočtu';
  bool _isRunning = false;

  void _runOnUIThread() {
    setState(() {
      _isRunning = true;
      _status = 'Počítám na UI vlákně...';
    });

      final result = countPrimes();

      setState(() {
        _isRunning = false;
        _status =
            'UI vlákno hotovo:\n${result.count} prvočísel za ${result.elapsed.inMilliseconds} ms';
      }); 
  }

  Future<void> _runOnIsolate() async {
    setState(() {
      _isRunning = true;
      _status = 'Počítám v Isolate...';
    });

    final result = await Isolate.run(() => countPrimes());

    setState(() {
      _isRunning = false;
      _status =
          'Isolate hotovo:\n${result.count} prvočísel za ${result.elapsed.inMilliseconds} ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? null : _runOnUIThread,
                    child: const Text('UI vlákno'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _isRunning ? null : _runOnIsolate,
                    child: const Text('Isolate'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Text(
                _status,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
    );
  }
}