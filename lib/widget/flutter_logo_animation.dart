import 'package:flutter/material.dart';

class FlutterLogoAnimation extends StatefulWidget {
  const FlutterLogoAnimation({Key? key}) : super(key: key);
  @override
  _FlutterLogoAnimationState createState() => _FlutterLogoAnimationState();
}

class _FlutterLogoAnimationState extends State<FlutterLogoAnimation> with SingleTickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = Tween(begin: -0.03, end: 0.03).animate(_controller);

  final duration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
  }
  @override
  void didUpdateWidget(FlutterLogoAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = duration;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      alignment: Alignment.topCenter,
      child: Image.asset('assets/images/flutter_top.png',
        color: Colors.white,
        colorBlendMode: BlendMode.srcIn,
        width: 160,
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
