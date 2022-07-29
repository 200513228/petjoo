import 'package:flutter/material.dart';

class ImageLoading extends StatefulWidget {
  final Widget image;
  final Widget child;
  final Color? color;
  final Duration duration;

  const ImageLoading({
    Key? key,
    required this.image,
    required this.child,
    this.color,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<ImageLoading> createState() => _ImageLoading();
}

class _ImageLoading extends State<ImageLoading> with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        //print(animation_1.value);
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.color,
      child: LayoutBuilder(
          builder: (context, constraints) => Transform.translate(
                offset: Offset(
                  0.0,
                  -30 * (animation_1.value <= .5 ? animation_1.value : 1.0 - animation_1.value),
                ),
                child: widget.image,
              )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  const Dot({Key? key, this.radius, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: 0.0,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
