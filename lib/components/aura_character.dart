import 'package:flutter/material.dart';
import 'package:super_legends/components/aura.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class AuraCharacter extends StatelessWidget {
  const AuraCharacter({
    Key? key,
    required this.isVisible,
    required this.positionX,
    required this.positionY,
    required this.auraImage,
    required this.direction,
    required this.auraSpriteCount,
    required this.characterImage,
    required this.auraCharacterSpriteCount,
  }) : super(key: key);

  final bool isVisible;
  final double positionX;
  final double positionY;
  final int auraImage;
  final DirectionEnum direction;
  final int auraSpriteCount;
  final int characterImage;
  final int auraCharacterSpriteCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*
        #######################################
        ############# AURA EFFECT #############
        #######################################
        */
        Visibility(
          visible: isVisible,
          child: Container(
            alignment: Alignment(positionX, positionY),
            child: Aura(
              image: auraImage,
              direction: direction,
              spriteCount: auraSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### AURA CHARACTER ############
        #######################################
        */
        Visibility(
          visible: isVisible,
          child: Container(
            alignment: Alignment(positionX, positionY),
            child: Character(
              image: characterImage,
              direction: direction,
              move: MoveEnum.aura,
              spriteCount: auraCharacterSpriteCount,
            ),
          ),
        ),
      ],
    );
  }
}
