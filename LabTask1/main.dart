import 'package:flutter/material.dart';

const int myThreshold = 8;
const Color mySeedColor = Colors.indigo;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS 442 Counter App',
      theme: ThemeData(colorSchemeSeed: mySeedColor),
      home: const MyHomePage(title: 'CS 442 MAD Hot Reload Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _resetCount = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });

    setState(() {
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value:'),

            const SizedBox(height: 8),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            if (_counter > myThreshold)
              const Text(
                "You're on a roll!",
                style: TextStyle(color: Colors.green),
              ),

            const SizedBox(height: 12),

            Text('Resets used: $_resetCount'),

            const SizedBox(height: 25),

            const Text('Built by Muhammad Ilyas · 04072313012'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
