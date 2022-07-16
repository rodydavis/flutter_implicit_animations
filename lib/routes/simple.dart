import 'package:flutter/material.dart';

import '../widgets/animated_state.dart';

class SimpleExample extends StatefulWidget {
  const SimpleExample({Key? key}) : super(key: key);

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends AnimatedState<SimpleExample> {
  var x = 0.0;
  var y = 0.0;
  var z = 0.0;

  @override
  void update(Duration time) {
    final t = delta.inMilliseconds / 1000;
    x += t;
    y += t;
    z += t;
  }

  @override
  Widget paint(BuildContext context, BoxConstraints constraints) {
    return Material(
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          transform: Matrix4.identity()
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          child: const Text(
            'Hello World',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
