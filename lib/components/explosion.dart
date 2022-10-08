import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_legends/enums/direction_enum.dart';

class Explosion extends StatelessWidget {
  const Explosion({
    Key? key,
    required this.image,
    required this.direction,
    required this.spriteCount,
  }) : super(key: key);

  final int image;
  final DirectionEnum direction;
  final int spriteCount;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 6;
    final double height = MediaQuery.of(context).size.height / 4;

    if (direction == DirectionEnum.left) {
      return SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          'assets/images/explosion/$image/explosion$spriteCount.png',
          fit: BoxFit.contain,
        ),
      );
    }
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          'assets/images/explosion/$image/explosion$spriteCount.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
