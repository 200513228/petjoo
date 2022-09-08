import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Color? background;
  final double dotRadius;
  final Duration duration;

  const Loading({
    Key? key,
    this.dotOneColor = const Color(0xFF0095D2),
    this.dotTwoColor = const Color(0xFF008375),
    this.dotThreeColor = Colors.red,
    this.dotRadius = 10,
    this.background,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<Loading> createState() => _Loading();
}

class _Loading extends State<Loading> with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.80, curve: Curves.ease),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.9, curve: Curves.ease),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 1.0, curve: Curves.ease),
      ),
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
      color: widget.background,
      child: LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth < 160
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(
                        0.0,
                        -30 *
                            (animation_1.value <= 0.50
                                ? animation_1.value
                                : 1.0 - animation_1.value),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Dot(
                          radius: widget.dotRadius,
                          color: widget.dotOneColor,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        0.0,
                        -30 *
                            (animation_2.value <= 0.50
                                ? animation_2.value
                                : 1.0 - animation_2.value),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Dot(
                          radius: widget.dotRadius,
                          color: widget.dotTwoColor,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        0.0,
                        -30 *
                            (animation_3.value <= 0.50
                                ? animation_3.value
                                : 1.0 - animation_3.value),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Dot(
                          radius: widget.dotRadius,
                          color: widget.dotThreeColor,
                        ),
                      ),
                    ),
                  ],
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
