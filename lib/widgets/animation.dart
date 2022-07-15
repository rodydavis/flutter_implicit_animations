import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class AnimationWidget<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  Duration elapsed = Duration.zero;
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) {
      this.elapsed = elapsed;
      update(elapsed);
      if (mounted) setState(() {});
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: paint);

  void update(Duration time);

  Widget paint(BuildContext context, BoxConstraints constraints);
}
