// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../constants/colors.dart';
import 'text_widget.dart';

class LoadingButtonWidget extends StatelessWidget {
  final String text;
  final String loadingText;
  final bool isLoading;
  final VoidCallback onPressed;

  const LoadingButtonWidget(
      {super.key,
      required this.text,
      required this.loadingText,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingAnimatedButton(
          child: TextWidget(text: loadingText, fontSize: 15), onTap: () {});
    } else {
      return InvertedButtonFb2(
        onPressed: onPressed,
        text: text,
      );
    }
  }
}

//default button
class InvertedButtonFb2 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const InvertedButtonFb2({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const primaryColor = LocalColorScheme.primary;

    return OutlinedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          side: MaterialStateProperty.all(
              const BorderSide(width: 1, color: primaryColor)),
          padding: MaterialStateProperty.all(const EdgeInsets.only(
              right: 75, left: 75, top: 12.5, bottom: 12.5)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)))),
      onPressed: onPressed,
      child: Text(text,
          style: GoogleFonts.urbanist(
              color: primaryColor, fontSize: 16, fontWeight: FontWeight.w700)),
    );
  }
}

//loading button
class LoadingAnimatedButton extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Function() onTap;
  final double width;
  final double height;

  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  const LoadingAnimatedButton(
      {Key? key,
      required this.child,
      required this.onTap,
      this.width = 200,
      this.height = 50,
      this.color = LocalColorScheme.primary,
      this.borderColor = Colors.white,
      this.borderRadius = 15.0,
      this.borderWidth = 3.0,
      this.duration = const Duration(milliseconds: 1500)})
      : super(key: key);

  @override
  State<LoadingAnimatedButton> createState() => _LoadingAnimatedButtonState();
}

class _LoadingAnimatedButtonState extends State<LoadingAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(
        widget.borderRadius,
      ),
      splashColor: widget.color,
      child: CustomPaint(
        painter: LoadingPainter(
            animation: _animationController,
            borderColor: widget.borderColor,
            borderRadius: widget.borderRadius,
            borderWidth: widget.borderWidth,
            color: widget.color),
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(5.5),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final Animation animation;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  LoadingPainter(
      {required this.animation,
      this.color = Colors.orange,
      this.borderColor = Colors.white,
      this.borderRadius = 15.0,
      this.borderWidth = 3.0})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
              colors: [
                color.withOpacity(.25),
                color,
              ],
              startAngle: 0.0,
              endAngle: vector.radians(180),
              stops: const [.75, 1.0],
              transform:
                  GradientRotation(vector.radians(360.0 * animation.value)))
          .createShader(rect);

    final path = Path.combine(
        PathOperation.xor,
        Path()
          ..addRRect(
              RRect.fromRectAndRadius(rect, Radius.circular(borderRadius))),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              rect.deflate(3.5), Radius.circular(borderRadius))));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            rect.deflate(1.5), Radius.circular(borderRadius)),
        Paint()
          ..color = borderColor
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
