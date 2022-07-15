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
  final List<Cube> cubes = <Cube>[];

  double x = 0.0, y = 0.0, z = 0.0;
  Color color = Colors.red;
  Offset offset = Offset.zero;

  void addCube(Size size) {
    final randomOffset = Offset(
      Random().nextDouble() * size.width,
      Random().nextDouble() * size.height,
    );
    final randomDelta = Random().nextDouble() * 20;
    final randomDirection = Offset(
      Random().nextDouble() * 2 - 1,
      Random().nextDouble() * 2 - 1,
    );
    final cube = Cube()
      ..offset = randomOffset
      ..delta = randomDelta
      ..direction = randomDirection;
    cubes.add(cube);
    debugPrint('Cube added: $randomOffset');
  }

  @override
  void start(Duration time) {
    final size = MediaQuery.of(context).size;
    addCube(size);
    super.start(time);
  }

  @override
  void update(Duration time) {
    for (final cube in cubes) {
      cube.update(time, constraints.biggest);
    }
  }

  @override
  Widget paint(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          for (final cube in cubes)
            Positioned.fromRect(
              rect: cube.rect,
              child: CustomPaint(
                painter: InlinePainter(
                  draw: (canvas, size) {
                    final paint = Paint()
                      ..color = cube.color
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addCube(constraints.biggest),
        icon: const Icon(Icons.add),
        label: Text('Cubes: ${cubes.length}'),
      ),
    );
  }
}

class Cube {
  Color color = Colors.black;
  Offset offset = Offset.zero;
  Size size = const Size(100, 100);
  double delta = 10;
  Offset direction = const Offset(0.1, 0.4);
  Rect get rect => offset & size;

  void update(Duration time, Size size) {
    // Move cube and change direction if out of bounds
    offset = offset + direction * delta;

    // Top
    if (offset.dy < 0) {
      direction = Offset(direction.dx, 1);
    }
    // Bottom
    if (offset.dy > size.height) {
      direction = Offset(direction.dx, -1);
    }
    // Left
    if (offset.dx < 0) {
      direction = Offset(1, direction.dy);
    }
    // Right
    if (offset.dx > size.width) {
      direction = Offset(-1, direction.dy);
    }

    // Change color
    color = Color.fromARGB(
      255,
      (offset.dx * 255 / size.width).round(),
      (offset.dy * 255 / size.height).round(),
      0,
    );
  }
}
