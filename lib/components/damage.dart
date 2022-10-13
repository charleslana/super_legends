import 'package:flutter/material.dart';
import 'package:super_legends/utils/theme_utils.dart';
import 'package:super_legends/utils/utils.dart';

class Damage extends StatelessWidget {
  const Damage({
    Key? key,
    required this.isVisible,
    required this.positionX,
    required this.positionY,
    required this.damage,
  }) : super(key: key);

  final bool isVisible;
  final double positionX;
  final double positionY;
  final int damage;

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.height / 20;

    return Visibility(
      visible: isVisible,
      child: Container(
        alignment: Alignment(positionX, positionY),
        child: Text(
          Utils.numberAbbreviation(damage),
          style: ThemeUtils.actionComcsBlack().copyWith(
            fontSize: fontSize,
            color: Colors.red,
            shadows: [
              const Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.white,
              ),
              const Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.white,
              ),
              const Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.white,
              ),
              const Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
