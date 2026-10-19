import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Muhammad Ilyas';
const String rollNo = '04072313012';
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

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

final String course = courses[u];
final int startCount = 3 + u;
final int stepSize = 1 + t % 4;
final int maxCount = 20 + 2 * t;
final int startSeconds = 5 + (t + u) % 6;
final int bugStep = 1 + u % 4;

final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),
    body: SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      StudentCard(
        name: studentName,
        roll: rollNo,
        course: course,
      ),
      const SizedBox(height: 12),
      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Start: $startCount', key: const Key('info-start')),
    Text('Step: $stepSize', key: const Key('info-step')),
    Text('Max: $maxCount', key: const Key('info-max')),
  ],
),
const SizedBox(height: 12),
const Tally(),
const SizedBox(height: 12),
const Countdown(),
const SizedBox(height: 12),
const BuggyCounter(),
    ],
  ),
),
    );
  }
}
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}
class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  final String name;
  final String roll;
  final String course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}
class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Bug clicks: $_clicks',
          key: const Key('bug-text'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
  setState(() {
    _clicks += bugStep;
  });
},
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

class GoalBanner extends StatelessWidget {
  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;

    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

 void _plus() {
  setState(() {
    _count += stepSize;
    if (_count > maxCount) _count = maxCount;
  });
}
void _minus() {
  setState(() {
    _count -= stepSize;
    if (_count < 0) _count = 0;
  });
}

void _reset() {
  setState(() {
    _count = startCount;
  });
}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
  children: [
    ElevatedButton(
      key: const Key('plus'),
      onPressed: _plus,
      child: Text('+$stepSize'),
    ),
    const SizedBox(width: 8),
    ElevatedButton(
      key: const Key('minus'),
      onPressed: _minus,
      child: Text('-$stepSize'),
    ),
    const SizedBox(width: 8),
    OutlinedButton(
      key: const Key('reset'),
      onPressed: _reset,
      child: const Text('Reset'),
    ),
  ],
),
      ],
    );
  }
}

class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _left = startSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _left > 0 ? 'Time left: $_left s' : 'Time is up!',
      key: const Key('time-left'),
    );
  }
}