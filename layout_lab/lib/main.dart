// main.dart - Team Board lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Muhammad Ilyas';
const String rollNo = '04072313012'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

const List<String> names = [
  'Ali',
  'Sara',
  'Omar',
  'Hina',
  'Zain',
  'Maya',
];

const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];

const List<String> crosses = [
  'start',
  'center',
  'end',
];

const List<String> hues = [
  'teal',
  'indigo',
  'orange',
  'pink',
  'green',
];

const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5);
final int tick = 1 + u % 3;
final int ticks = 4 + u % 4;
final int stopAt = startSec + ticks * tick;

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3;

// Step 6: axes
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5];

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Team Board',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Board: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),

            const Clock(),
          ],
        ),
      ),
    );
  }
}

// Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC '
      '(taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, '
      'bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
      ),
    );
  }
}

// Provided for Step 7. It overflows on purpose. Do not rename.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Part A: read the widget tree of the $course board from top to bottom.',
          key: const Key('sum-a'),
        ),
        Text(
          'Part B: build each box from small widgets and never extend a built-in class.',
          key: const Key('sum-b'),
        ),
        Text(
          'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
          key: const Key('sum-c'),
        ),
      ],
    );
  }
}

// ======================================================
// STEP 1 + STEP 2 + STEP 3
// ======================================================

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  // Think Step 1:
  // The Timer is started in initState because initState runs only once
  // when the State is created.
  // If the Timer were started inside build, every rebuild would create
  // another Timer and the clock would keep getting faster.

  // Think Step 2:
  // Builds goes up once per second because each timer tick calls setState once,
  // which causes one rebuild.
  // If _timer.cancel() were missing from dispose, the Timer could try to call
  // setState after the widget had been removed from the tree.

  // Think Step 3:
  // The Widget is cheap and can be replaced on every rebuild.
  // The Element usually stays at the same location in the tree and connects
  // the Widget to its State.
  // The RenderObject is responsible for lower-level layout and painting.

  @override
  void initState() {
    super.initState();

    lifecycleLog.add('initState');

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() => _seconds += tick);

        if (_seconds >= stopAt) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session: $_seconds s',
          key: const Key('clock'),
        ),
        Text(
          'Builds: $_builds',
          key: const Key('builds'),
        ),

        // Step 3
        Probe(seconds: _seconds),
      ],
    );
  }
}

class Probe extends StatelessWidget {
  const Probe({
    super.key,
    required this.seconds,
  });

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seen at: $seconds s',
          key: const Key('probe-seen'),
        ),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text(
          'Scaffold above me: $above',
          key: const Key('probe-above'),
        ),
      ],
    );
  }
}