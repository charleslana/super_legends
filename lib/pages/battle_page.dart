import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:super_legends/components/aura.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/components/explosion.dart';
import 'package:super_legends/components/skill.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  late Timer standingCharacterTimer;
  late Timer attackCharacterTimer;
  late Timer specialCharacterTimer;
  late Timer explosionCharacterTimer;
  final attackAudio = AudioPlayer();
  final auraAudio = AudioPlayer();
  final specialAudio = AudioPlayer();
  final battleAudio = AudioPlayer();
  late bool isBattleAudioPlaying;

  int standingSpriteCount = 1;
  int attackSpriteCount = 0;
  int specialSpriteCount = 1;
  int explosionSpriteCount = 1;

  bool standingPlayer1 = true;
  bool attackPlayer1 = false;
  bool auraPlayer1 = false;
  bool specialPlayer = false;
  bool specialEffect = false;
  bool explosionEffect = false;

  bool defenseEnemy1 = false;

  bool disableActionButton = false;

  void moveCharacter() {
    standingCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        standingSpriteCount++;

        if (standingSpriteCount > 2) {
          standingSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterAttack() {
    attackCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        attackSpriteCount++;

        if (attackSpriteCount > 3) {
          attackSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterSpecial() {
    specialCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        specialSpriteCount++;

        if (specialSpriteCount > 8) {
          specialSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterExplosion() {
    explosionCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        explosionSpriteCount++;

        if (explosionSpriteCount > 12) {
          explosionSpriteCount = 1;
        }
      });
    });
  }

  void playerAttack(int characterPosition) {
    stopAllMoves();
    attackAudio.play(AssetSource('audio/teleport_combo.ogg'));
    setState(() {
      disableActionButton = true;
      standingPlayer1 = false;
    });
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      timer.cancel();
      moveCharacterAttack();
      setState(() {
        attackPlayer1 = true;

        defenseEnemy1 = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      attackCharacterTimer.cancel();
      setState(() {
        attackPlayer1 = false;
        standingPlayer1 = true;

        defenseEnemy1 = false;

        disableActionButton = false;
        attackSpriteCount = 0;
      });
    });
  }

  void playerAura() {
    stopAllMoves();
    auraAudio.play(AssetSource('audio/aura1.ogg'));
    setState(() {
      disableActionButton = true;
      auraPlayer1 = true;
      standingPlayer1 = false;
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      setState(() {
        disableActionButton = false;
        auraPlayer1 = false;
        standingPlayer1 = true;
      });
    });
  }

  void playerSpecial() {
    stopAllMoves();
    specialAudio.play(AssetSource('audio/special1.ogg'));
    setState(() {
      disableActionButton = true;
      standingPlayer1 = false;
      specialPlayer = true;
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timer.cancel();
      moveCharacterSpecial();
      setState(() {
        specialEffect = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1570), (timer) {
      timer.cancel();
      moveCharacterExplosion();
      setState(() {
        specialEffect = false;
        explosionEffect = true;
        defenseEnemy1 = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 2200), (timer) {
      timer.cancel();
      specialCharacterTimer.cancel();
      explosionCharacterTimer.cancel();
      setState(() {
        specialPlayer = false;
        disableActionButton = false;
        explosionEffect = false;
        standingPlayer1 = true;
        specialSpriteCount = 0;
        explosionSpriteCount = 0;
        defenseEnemy1 = false;
      });
    });
  }

  void loopBattleAudio() {
    playBattleAudio();
    battleAudio.onPlayerComplete.listen((event) {
      playBattleAudio();
    });
  }

  void playBattleAudio() {
    setState(() {
      isBattleAudioPlaying = true;
    });
    battleAudio.play(AssetSource('audio/battle1.ogg'));
  }

  void stopBattleAudio() {
    setState(() {
      isBattleAudioPlaying = false;
    });
    battleAudio.stop();
  }

  void stopAllMoves() {
    attackAudio
      ..stop()
      ..dispose();
    auraAudio
      ..stop()
      ..dispose();
    specialAudio
      ..stop()
      ..dispose();
  }

  void disposeAudio() {
    battleAudio
      ..stop()
      ..dispose();
    stopAllMoves();
  }

  @override
  void initState() {
    loopBattleAudio();
    moveCharacter();
    super.initState();
  }

  @override
  void dispose() {
    standingCharacterTimer.cancel();
    disposeAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                image: const DecorationImage(
                  image: AssetImage('assets/images/maps/1.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  //Player 1 - Meio
                  //Aura
                  Visibility(
                    visible: auraPlayer1,
                    child: Container(
                      alignment: const Alignment(-0.6, 0.6),
                      child: Aura(
                        image: 1,
                        direction: DirectionEnum.left,
                        spriteCount: standingSpriteCount,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: auraPlayer1,
                    child: Container(
                      alignment: const Alignment(-0.6, 0.6),
                      child: const Character(
                        image: 1,
                        direction: DirectionEnum.left,
                        move: MoveEnum.aura,
                        spriteCount: 1,
                      ),
                    ),
                  ),
                  //Standing
                  Visibility(
                    visible: standingPlayer1,
                    child: Container(
                      alignment: const Alignment(-0.6, 0.6),
                      child: Character(
                        image: 1,
                        direction: DirectionEnum.left,
                        move: MoveEnum.standing,
                        spriteCount: standingSpriteCount,
                      ),
                    ),
                  ),
                  //Special
                  Visibility(
                    visible: specialPlayer,
                    child: Container(
                      alignment: const Alignment(-0.2, 0.5),
                      child: const Character(
                        image: 1,
                        direction: DirectionEnum.left,
                        move: MoveEnum.special,
                        spriteCount: 1,
                      ),
                    ),
                  ),
                  //Special effect
                  Visibility(
                    visible: specialEffect,
                    child: Container(
                      alignment: const Alignment(0.7, 0.5),
                      child: Skill(
                        image: 1,
                        direction: DirectionEnum.left,
                        spriteCount: specialSpriteCount,
                      ),
                    ),
                  ),

                  // Meio
                  //Enemy 1
                  Visibility(
                    visible: !defenseEnemy1,
                    child: Container(
                      alignment: const Alignment(0.8, 0.6),
                      child: Character(
                        image: 2,
                        direction: DirectionEnum.right,
                        move: MoveEnum.standing,
                        spriteCount: standingSpriteCount,
                      ),
                    ),
                  ),
                  // Enemy defense
                  Visibility(
                    visible: defenseEnemy1,
                    child: Container(
                      alignment: const Alignment(0.8, 0.6),
                      child: const Character(
                        image: 2,
                        direction: DirectionEnum.right,
                        move: MoveEnum.defense,
                        spriteCount: 1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: explosionEffect,
                    child: Container(
                      alignment: const Alignment(0.8, 0.6),
                      child: Explosion(
                        image: 1,
                        direction: DirectionEnum.right,
                        spriteCount: explosionSpriteCount,
                      ),
                    ),
                  ),
                  // Player Attack
                  Visibility(
                    visible: attackPlayer1,
                    child: Container(
                      alignment: const Alignment(0.65, 0.6),
                      child: Character(
                        image: 1,
                        direction: DirectionEnum.left,
                        move: MoveEnum.attack,
                        spriteCount: attackSpriteCount,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IgnorePointer(
                          ignoring: disableActionButton,
                          child: ElevatedButton(
                            onPressed: () => playerAttack(1),
                            child: const Text('Atk base'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IgnorePointer(
                          ignoring: disableActionButton,
                          child: ElevatedButton(
                            onPressed: playerAura,
                            child: const Text('Ki'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IgnorePointer(
                          ignoring: disableActionButton,
                          child: ElevatedButton(
                            onPressed: playerSpecial,
                            child: const Text('Special'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: isBattleAudioPlaying
                              ? stopBattleAudio
                              : playBattleAudio,
                          child: Text(isBattleAudioPlaying
                              ? 'Stop bg audio'
                              : 'Play bg audio'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
