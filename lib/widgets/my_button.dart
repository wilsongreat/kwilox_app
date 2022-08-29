import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  final double? height;
  final double? width;
  final Widget child;

  const MyButton(
      {Key? key,
      required this.onPressed,
      this.color,
      this.height,
      this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: color ?? Color(0xFF3D16D6),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 5,
              )
            ]),
        child: child,
      ),
    );
  }
}
