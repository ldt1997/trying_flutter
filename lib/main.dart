import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // 第三方图表库

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab0: Flutter + AI Prototype',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

/// ------------------
/// 主页
/// ------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI-driven Prototype')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Lab0: Exploring Flutter + AI'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistogramScreen()),
                );
              },
              child: const Text('📊 Open Histogram'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
              child: const Text('ℹ️ About this project'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------
/// 柱状图页面
/// ------------------
class HistogramScreen extends StatefulWidget {
  const HistogramScreen({super.key});

  @override
  State<HistogramScreen> createState() => _HistogramScreenState();
}

class _HistogramScreenState extends State<HistogramScreen> {
  final List<List<double>> datasets = const [
    [2, 4, 3, 5, 1],
    [4, 1, 2, 5, 3],
  ];
  int active = 0;

  @override
  Widget build(BuildContext context) {
    final data = datasets[active];

    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Histogram')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, meta) =>
                            Text('B${val.toInt() + 1}'),
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    data.length,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: data[i],
                          width: 20,
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    ),
                  ),
                ),
                swapAnimationDuration: const Duration(milliseconds: 700),
                swapAnimationCurve: Curves.easeInOutCubic,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                setState(() => active = active == 0 ? 1 : 0);
              },
              icon: const Icon(Icons.sync),
              label: Text(active == 0
                  ? 'Switch to Dataset #2'
                  : 'Switch to Dataset #1'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// ------------------
/// About 页面
/// ------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About this project')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About the Lab0 Prototype',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This small app demonstrates how a low-fidelity paper sketch '
              'can evolve into a working interactive prototype using Flutter. '
              'It also shows how AI tools (like ChatGPT) and open-source '
              'packages (like fl_chart) can accelerate iteration.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Key Points:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Built with Flutter + Dart\n'
                '• Animated chart using fl_chart\n'
                '• Simple navigation flow (Home → Histogram → About)\n'
                '• Designed through AI-assisted prototyping'),
            const SizedBox(height: 24),
            Center(
              child: FilledButton.icon(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                label: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
