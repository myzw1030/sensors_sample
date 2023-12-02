import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double dx = 0;
  double dy = 0;
  final double ballDiameter = 50;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        // ボールの位置を更新
        dx -= event.x * 50;
        dy += event.y * 50;
        // 画面の範囲を超えないように座標は 0 と (画面の幅 - ボールの直径) の間に制限
        dx = dx.clamp(0, MediaQuery.sizeOf(context).width - ballDiameter);
        dy = dy.clamp(0, MediaQuery.sizeOf(context).height - ballDiameter);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 60),
            left: dx,
            top: dy,
            child: BallWidget(ballDiameter: ballDiameter),
          ),
        ],
      ),
    );
  }
}

class BallWidget extends StatelessWidget {
  const BallWidget({
    super.key,
    required this.ballDiameter,
  });

  final double ballDiameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballDiameter,
      height: ballDiameter,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
