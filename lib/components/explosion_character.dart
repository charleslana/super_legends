import 'package:flutter/material.dart';
import 'package:super_legends/components/explosion.dart';
import 'package:super_legends/enums/direction_enum.dart';

class ExplosionCharacter extends StatelessWidget {
  const ExplosionCharacter({
    Key? key,
    required this.isVisible,
    required this.direction,
    required this.positionX,
    required this.positionY,
    required this.image,
    required this.spriteCount,
  }) : super(key: key);

  final bool isVisible;
  final DirectionEnum direction;
  final double positionX;
  final double positionY;
  final int image;
  final int spriteCount;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        alignment: Alignment(positionX, positionY),
        child: Explosion(
          image: image,
          direction: direction,
          spriteCount: spriteCount,
        ),
      ),
    );
  }
}
