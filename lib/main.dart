import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demoああ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  double dx = 100;
  double dy = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<GyroscopeEvent>(
        stream: SensorsPlatform.instance.gyroscopeEventStream(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            dx = dx + (snapshot.data!.y * 10);
            dy = dy + (snapshot.data!.x * 10);
          }
          return Transform.translate(
            offset: Offset(dx, dy),
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 20,
            ),
          );
        },
      ),
    );
  }
}
