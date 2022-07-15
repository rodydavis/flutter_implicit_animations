import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/animation.dart';
import '../widgets/inline_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends AnimationWidget<HomeScreen> {
  double x = 0.0, y = 0.0, z = 0.0;
  Color color = Colors.red;
  Offset offset = Offset.zero;

  @override
  void update(Duration time) {
    x += 0.01;
    y += 0.01;
    final t = time.inMilliseconds / 1000;
    color = Color.fromARGB(
      255,
      (sin(t) * 127 + 128).floor(),
      (cos(t) * 127 + 128).floor(),
      (t * 127 + 128).floor(),
    );
    offset = Offset(
      sin(t) * 100,
      cos(t) * 100,
    );
  }

  @override
  Widget paint(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: constraints.maxWidth * 0.5,
            top: constraints.maxHeight * 0.5,
            width: 100,
            height: 100,
            child: Container(
              transform: Matrix4.identity()
                ..rotateZ(z)
                ..rotateY(y)
                ..rotateX(x),
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fromRect(
            rect: offset.translate(
                  constraints.maxWidth * 0.2,
                  constraints.maxHeight * 0.2,
                ) &
                const Size(100, 100),
            child: CustomPaint(
              painter: InlinePainter(
                draw: (canvas, size) {
                  final paint = Paint()
                    ..color = color
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 2;
                  final rect = Rect.fromLTWH(0, 0, size.width, size.height);
                  canvas.drawRect(rect, paint);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
