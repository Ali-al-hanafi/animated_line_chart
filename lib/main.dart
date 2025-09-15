import 'dart:math';
import 'package:custom_line_chart_widget/line_graph.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Custom Graph Widget'),
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
  double _counter = Random().nextDouble() % 5;
  double _counter1 = Random().nextDouble() % 5;
  double _counter2 = Random().nextDouble() % 5;
  double _counter3 = Random().nextDouble() % 5;

  void _incrementCounter() {
    setState(() {
      _counter = Random().nextDouble() % 5;
      _counter1 = Random().nextDouble() % 5;
      _counter2 = Random().nextDouble() % 5;
      _counter3 = Random().nextDouble() % 5;
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
        child: CurvedLineGraph(
          curveStops: [
            Offset(0.0, 0.0),
            Offset(1.0, _counter),
            Offset(2.0, _counter1),
            Offset(3.0, _counter3),
            Offset(4.0, _counter2),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
