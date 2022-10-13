import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:super_legends/components/aura_character.dart';
import 'package:super_legends/components/button.dart';
import 'package:super_legends/components/damage.dart';
import 'package:super_legends/components/enemy.dart';
import 'package:super_legends/components/explosion_character.dart';
import 'package:super_legends/components/player.dart';
import 'package:super_legends/components/special.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/utils/utils.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  /*
  #######################################
  ################ TIMER ################
  #######################################
  */
  late Timer standingCharacterTimer;
  late Timer attackCharacterTimer;
  late Timer specialEffectTimer;
  late Timer explosionCharacterTimer;
  Timer damageTimer = Timer.periodic(Duration.zero, (timer) {});
  late Timer auraTimer;

  /*
  #######################################
  ################ AUDIO ################
  #######################################
  */
  bool isAudioActive = true;
  final attackAudio = AudioPlayer();
  final auraAudio = AudioPlayer();
  final specialAudio = AudioPlayer();
  final battleAudio = AudioPlayer();
  late bool isBattleAudioPlaying;

  /*
  #######################################
  ################ MAP ################
  #######################################
  */
  int mapImage = 1;

  /*
  #######################################
  ############## PLAYER 1 ###############
  #######################################
  */
  int imageCharacter1 = 1;
  bool standingPlayer1 = true;
  bool attackPlayer1 = false;
  bool auraPlayer1 = false;
  bool defensePlayer1 = false;

  /*
  #######################################
  ############## DYNAMIC ################
  #######################################
  */
  DirectionEnum direction = DirectionEnum.left;
  bool specialCharacterVisible = false;
  double specialCharacterPositionX = -0.2;
  double specialCharacterPositionY = 0.5;
  bool specialEffectVisible = false;
  double specialEffectPositionX = 0.7;
  double specialEffectPositionY = 0.5;
  int specialEffectImage = 1;
  int specialEffectSpriteCount = 0;
  int specialCharacterImage = 1;
  int specialCharacterSpriteCount = 1;
  bool isExplosionVisible = false;
  double explosionPositionX = 0.8;
  double explosionPositionY = 0.6;
  int explosionImage = 1;
  int explosionSpriteCount = 0;
  bool auraVisible = false;
  double auraPositionX = -0.6;
  double auraPositionY = 0.6;
  int auraImage = 1;
  DirectionEnum auraDirection = DirectionEnum.left;
  int auraCharacterImage = 1;
  int auraSpriteCount = 1;
  int auraCharacterSpriteCount = 1;
  int standingSpriteCount = 1;
  int attackSpriteCount = 0;
  bool disableActionButton = false;
  bool damageVisible = false;
  double damagePositionX = 0.7;
  double damagePositionY = 0.4;
  int damage = 0;

  /*
  #######################################
  ############## ENEMY 1 ################
  #######################################
  */
  bool defenseEnemy = false;
  int imageEnemy = 2;
  int defenseEnemySpriteCount = 1;
  bool standingEnemy = true;
  bool attackEnemy = false;

  /*
  #######################################
  ############### MOVES #################
  #######################################
  */
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

  void moveCharacterAttack(int maxSpriteCount) {
    attackCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        attackSpriteCount++;

        if (attackSpriteCount > maxSpriteCount) {
          attackSpriteCount = 1;
        }
      });
    });
  }

  void moveEffectSpecial(int specialCount, int milliseconds) {
    specialEffectTimer =
        Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      setState(() {
        specialEffectSpriteCount++;

        if (specialEffectSpriteCount > specialCount) {
          specialEffectSpriteCount = 1;
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

  void moveAura() {
    auraTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        auraSpriteCount++;

        if (auraSpriteCount > 2) {
          auraSpriteCount = 1;
        }
      });
    });
  }

  /*
  #######################################
  ############# DAMAGE ##################
  #######################################
  */
  void showDamage(double damagePosition) {
    if (damageTimer.isActive) {
      damageTimer.cancel();
    }
    damageTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        damagePositionX = damagePosition;
        damageVisible = true;
        damagePositionY -= 0.01;
        damage = 145210;
      });
      if (damagePositionY < 0.3) {
        timer.cancel();
        setState(() {
          damagePositionY = 0.4;
          damageVisible = false;
        });
      }
    });
  }

  /*
  #######################################
  ############## ATTACK #################
  #######################################
  */
  void playerAttack(int characterPosition) {
    if (isAudioActive) {
      attackAudio.play(AssetSource('audio/teleport_combo.ogg'));
    }
    setState(() {
      disableActionButton = true;
      standingPlayer1 = false;
    });
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      timer.cancel();
      moveCharacterAttack(3);
      setState(() {
        attackPlayer1 = true;

        defenseEnemy = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      attackCharacterTimer.cancel();
      attackAudio.stop();
      showDamage(0.7);
      setState(() {
        attackPlayer1 = false;
        standingPlayer1 = true;

        defenseEnemy = false;

        disableActionButton = false;
        attackSpriteCount = 0;
      });
    });
  }

  void enemyAttack(int enemyPosition) {
    if (isAudioActive) {
      attackAudio.play(AssetSource('audio/teleport_combo.ogg'));
    }
    setState(() {
      disableActionButton = true;
      standingEnemy = false;
    });
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      timer.cancel();
      moveCharacterAttack(11);
      setState(() {
        attackEnemy = true;

        defensePlayer1 = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      attackCharacterTimer.cancel();
      attackAudio.stop();
      showDamage(-0.5);
      setState(() {
        attackEnemy = false;
        standingEnemy = true;

        defensePlayer1 = false;

        disableActionButton = false;
        attackSpriteCount = 0;
      });
    });
  }

  /*
  #######################################
  ############### AURA ##################
  #######################################
  */
  void playerAura() {
    if (isAudioActive) {
      auraAudio.play(AssetSource('audio/aura1.ogg'));
    }
    setState(() {
      auraImage = 1;
      auraCharacterImage = 1;
      auraDirection = DirectionEnum.left;
      auraVisible = true;
      auraPositionX = -0.6;
      auraPositionY = 0.6;
      disableActionButton = true;
      standingPlayer1 = false;
    });
    moveAura();
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      auraTimer.cancel();
      auraAudio.stop();
      setState(() {
        disableActionButton = false;
        auraVisible = false;
        standingPlayer1 = true;
      });
    });
  }

  void enemyAura() {
    if (isAudioActive) {
      auraAudio.play(AssetSource('audio/aura1.ogg'));
    }
    setState(() {
      auraImage = 2;
      auraCharacterImage = 2;
      auraDirection = DirectionEnum.right;
      auraVisible = true;
      auraPositionX = 0.8;
      auraPositionY = 0.6;
      disableActionButton = true;
      standingEnemy = false;
    });
    moveAura();
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      auraTimer.cancel();
      auraAudio.stop();
      setState(() {
        disableActionButton = false;
        auraVisible = false;
        standingEnemy = true;
      });
    });
  }

  /*
  #######################################
  ############## SPECIAL ################
  #######################################
  */
  void playerSpecial() {
    if (isAudioActive) {
      specialAudio.play(AssetSource('audio/special1.ogg'));
    }
    setState(() {
      direction = DirectionEnum.left;
      specialCharacterImage = 1;
      specialEffectImage = 1;
      specialCharacterPositionX = -0.2;
      specialCharacterPositionY = 0.5;
      specialEffectPositionX = 0.7;
      specialEffectPositionY = 0.5;
      disableActionButton = true;
      standingPlayer1 = false;
      specialCharacterVisible = true;
      explosionPositionX = 0.8;
      explosionPositionY = 0.6;
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timer.cancel();
      moveEffectSpecial(8, 150);
      setState(() {
        specialEffectVisible = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1570), (timer) {
      timer.cancel();
      moveCharacterExplosion();
      setState(() {
        specialEffectVisible = false;
        isExplosionVisible = true;
        defenseEnemy = true;
        showDamage(0.7);
      });
    });
    Timer.periodic(const Duration(milliseconds: 2200), (timer) {
      timer.cancel();
      specialEffectTimer.cancel();
      explosionCharacterTimer.cancel();
      specialAudio.stop();
      setState(() {
        specialCharacterVisible = false;
        disableActionButton = false;
        isExplosionVisible = false;
        standingPlayer1 = true;
        specialEffectSpriteCount = 0;
        specialCharacterSpriteCount = 1;
        explosionSpriteCount = 0;
        defenseEnemy = false;
      });
    });
  }

  void enemySpecial() {
    if (isAudioActive) {
      specialAudio.play(AssetSource('audio/special2.ogg'));
    }
    setState(() {
      direction = DirectionEnum.right;
      specialCharacterImage = 2;
      specialEffectImage = 2;
      specialCharacterPositionX = 0.3;
      specialCharacterPositionY = 0.5;
      specialEffectPositionX = -0.6;
      specialEffectPositionY = 0.5;
      disableActionButton = true;
      standingEnemy = false;
      specialCharacterVisible = true;
      explosionPositionX = -0.6;
      explosionPositionY = 0.6;
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timer.cancel();
      specialCharacterSpriteCount = 2;
      moveEffectSpecial(15, 90);
      setState(() {
        specialEffectVisible = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1570), (timer) {
      timer.cancel();
      moveCharacterExplosion();
      setState(() {
        specialEffectVisible = false;
        isExplosionVisible = true;
        defensePlayer1 = true;
        showDamage(-0.5);
      });
    });
    Timer.periodic(const Duration(milliseconds: 2200), (timer) {
      timer.cancel();
      specialEffectTimer.cancel();
      explosionCharacterTimer.cancel();
      specialAudio.stop();
      setState(() {
        specialCharacterVisible = false;
        disableActionButton = false;
        isExplosionVisible = false;
        standingEnemy = true;
        specialEffectSpriteCount = 0;
        specialCharacterSpriteCount = 1;
        explosionSpriteCount = 0;
        defensePlayer1 = false;
      });
    });
  }

  /*
  #######################################
  ############### AUDIO #################
  #######################################
  */
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

  void playEffectAudio() {
    setState(() {
      isAudioActive = true;
    });
  }

  void stopEffectAudio() {
    setState(() {
      isAudioActive = false;
    });
  }

  /*
  #######################################
  ############### INIT ##################
  #######################################
  */
  @override
  void initState() {
    loopBattleAudio();
    moveCharacter();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils.loadImages(context);
    Utils.loadFonts();
    super.didChangeDependencies();
  }

  /*
  #######################################
  ############## DISPOSE ################
  #######################################
  */
  @override
  void dispose() {
    standingCharacterTimer.cancel();
    battleAudio
      ..stop()
      ..dispose();
    attackAudio.dispose();
    auraAudio.dispose();
    specialAudio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                image: DecorationImage(
                  image: AssetImage('assets/images/maps/$mapImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  /*
                  #######################################
                  ################ AURA #################
                  #######################################
                  */
                  AuraCharacter(
                    isVisible: auraVisible,
                    positionX: auraPositionX,
                    positionY: auraPositionY,
                    auraImage: auraImage,
                    direction: auraDirection,
                    auraSpriteCount: auraSpriteCount,
                    characterImage: auraCharacterImage,
                    auraCharacterSpriteCount: auraCharacterSpriteCount,
                  ),
                  /*
                  #######################################
                  ############## PLAYER 1 ###############
                  #######################################
                  */
                  Player(
                    playerImage: imageCharacter1,
                    standingPlayerVisible: standingPlayer1,
                    standingPlayerSpriteCount: standingSpriteCount,
                    defenseSpriteCount: 1,
                    defenseVisible: defensePlayer1,
                    playerPositionX: -0.6,
                    playerPositionY: 0.6,
                    enemyAttackPositionX: -0.5,
                    enemyAttackPositionY: 0.6,
                    enemyAttackSpriteCount: attackSpriteCount,
                    enemyImage: imageEnemy,
                    enemyVisible: attackEnemy,
                  ),
                  /*
                  #######################################
                  ############### ENEMY 1 ###############
                  #######################################
                  */
                  Enemy(
                    enemyImage: imageEnemy,
                    defenseVisible: defenseEnemy,
                    defenseSpriteCount: defenseEnemySpriteCount,
                    standingEnemyVisible: standingEnemy,
                    standingEnemySpriteCount: standingSpriteCount,
                    playerVisible: attackPlayer1,
                    playerImage: imageCharacter1,
                    playerAttackSpriteCount: attackSpriteCount,
                    playerAttackPositionX: 0.7,
                    playerAttackPositionY: 0.6,
                    enemyPositionX: 0.8,
                    enemyPositionY: 0.6,
                  ),
                  /*
                  #######################################
                  ############### SPECIAL ###############
                  #######################################
                  */
                  Special(
                    direction: direction,
                    specialCharacterVisible: specialCharacterVisible,
                    specialCharacterPositionX: specialCharacterPositionX,
                    specialCharacterPositionY: specialCharacterPositionY,
                    specialCharacterImage: specialCharacterImage,
                    specialCharacterSpriteCount: specialCharacterSpriteCount,
                    specialEffectVisible: specialEffectVisible,
                    specialEffectPositionX: specialEffectPositionX,
                    specialEffectPositionY: specialEffectPositionY,
                    specialEffectImage: specialEffectImage,
                    specialEffectSpriteCount: specialEffectSpriteCount,
                  ),
                  /*
                  #######################################
                  ######### EXPLOSION CHARACTER #########
                  #######################################
                  */
                  ExplosionCharacter(
                    isVisible: isExplosionVisible,
                    direction: direction,
                    positionX: explosionPositionX,
                    positionY: explosionPositionY,
                    image: explosionImage,
                    spriteCount: explosionSpriteCount,
                  ),
                  /*
                  #######################################
                  ############### DAMAGE ################
                  #######################################
                  */
                  Damage(
                    isVisible: damageVisible,
                    positionX: damagePositionX,
                    positionY: damagePositionY,
                    damage: damage,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[500],
              child: Center(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Button(
                                  title: 'Atk base',
                                  callback: () => playerAttack(1),
                                  disableActionButton: disableActionButton,
                                ),
                                Button(
                                  title: 'Atk base enemy',
                                  callback: () => enemyAttack(1),
                                  disableActionButton: disableActionButton,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Button(
                                  title: 'Ki',
                                  callback: playerAura,
                                  disableActionButton: disableActionButton,
                                ),
                                Button(
                                  title: 'Ki enemy',
                                  callback: enemyAura,
                                  disableActionButton: disableActionButton,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Button(
                                  title: 'Special',
                                  callback: playerSpecial,
                                  disableActionButton: disableActionButton,
                                ),
                                Button(
                                  title: 'Special enemy',
                                  callback: enemySpecial,
                                  disableActionButton: disableActionButton,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Button(
                                  title: isBattleAudioPlaying
                                      ? 'Stop bg audio'
                                      : 'Play bg audio',
                                  callback: isBattleAudioPlaying
                                      ? stopBattleAudio
                                      : playBattleAudio,
                                ),
                                Button(
                                  title: isAudioActive
                                      ? 'Stop effect audio'
                                      : 'Play effect audio',
                                  callback: isAudioActive
                                      ? stopEffectAudio
                                      : playEffectAudio,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
