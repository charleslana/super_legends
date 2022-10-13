import 'package:flutter/material.dart';
import 'package:super_legends/stores/battle_store.dart';

class BattleProvider extends InheritedNotifier<BattleStore> {
  const BattleProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static BattleStore of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BattleProvider>()!
        .notifier!;
  }
}
