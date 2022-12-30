import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBackdropWidget extends StatelessWidget {
  final Widget? child;
  const GlassBackdropWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: child,
    );
  }
}

BoxDecoration glassBoxDecoration([Color color = const Color(0x11FFFFFF), double radius = 15]) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [color, Colors.white.withOpacity(0.05)],
    ),
    image: const DecorationImage(
      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/b/b0/White.noise.b.w.png'),
      fit: BoxFit.cover,
      opacity: 0.025
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 25,
          spreadRadius: -5
      ),
    ],
    borderRadius: BorderRadius.circular(15),
    border: Border.all(width: 1.5, color: Colors.white24)
  );
}
