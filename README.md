# 📈 Custom Line Chart Widget (Flutter)

A Flutter package that provides a customizable and animated curved line chart widget.  
This widget allows you to plot smooth curves, animate data changes, and display axis labels with ease.

---

## ✨ Features

- Draws **smooth cubic Bezier curves** through data points.
- Supports **animated transitions** when data changes.
- Configurable:
  - Axis labels (`x-axis`, `y-axis`).
  - Curve color, thickness, and background.
  - Data points color and size.
- Scales input points to fit the canvas automatically.
- Lightweight and easy to integrate.

---

## 📂 Project Structure

lib/
├── custom_curve.dart # CustomPainter that draws axes, curve, and data points
├── line_graph.dart # Stateful widget that animates curve updates
main.dart # Example usage of the widget

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0 recommended)
- Dart SDK

### Installation

Clone this repository:

```bash
git clone https://github.com/<Ali-al-hanafi>/animated_line_chart.git
cd custom_line_chart_widget
Run the app:

bash

flutter run

📖 Usage Example
dart
Copy code
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:custom_line_chart_widget/line_graph.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = Random().nextDouble() % 5;

  void _updateGraph() {
    setState(() {
      _counter = Random().nextDouble() % 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CurvedLineGraph(
          curveStops: [
            const Offset(0.0, 0.0),
            Offset(1.0, _counter),
            Offset(2.0, Random().nextDouble() % 5),
            Offset(3.0, Random().nextDouble() % 5),
            Offset(4.0, Random().nextDouble() % 5),
          ],
          curveColor: Colors.blue,
          axisColor: Colors.black,
          pointsColor: Colors.red,
          horizontalAxisText: "X-Axis",
          verticalAxisText: "Y-Axis",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateGraph,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

📊 Demo
The graph animates smoothly whenever you update the curveStops list.



⚙️ Customization
You can configure:

curveColor, curveWidth

backgroundColor

pointsColor, pointsWidth

horizontalAxisText, verticalAxisText

axesFontColor, axesFontWeight, axesFontStyle, fontSize

🛠️ Built With
Flutter

Dart

🤝 Contributing
Contributions, issues, and feature requests are welcome!
Feel free to fork and submit a PR.

📜 License
This project is licensed under the MIT License
```
