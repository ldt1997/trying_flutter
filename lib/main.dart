import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab0 Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

// Home page
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter + Interaction')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistogramScreen()),
            );
          },
          child: const Text('Open Histogram'),
        ),
      ),
    );
  }
}

// Histogram page
class HistogramScreen extends StatefulWidget {
  const HistogramScreen({super.key});

  @override
  State<HistogramScreen> createState() => _HistogramScreenState();
}

class _HistogramScreenState extends State<HistogramScreen> {
  final List<List<double>> datasets = const [
    [2, 4, 1, 5, 3],
    [4, 2, 5, 1, 3],
  ];
  int active = 0;

  @override
  Widget build(BuildContext context) {
    final data = datasets[active];
    return Scaffold(
      appBar: AppBar(title: const Text('Histogram')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < data.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 30,
                    height: data[i] * 40,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              setState(() => active = active == 0 ? 1 : 0);
            },
            child: Text('Switch Dataset'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
