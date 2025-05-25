import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../models/dice_state.dart';
import 'app_state.dart';

class DiceNotifier extends Notifier<AppState> {
  final Random _random = Random();
  final Map<int, List<(int, int)>> _sumToPairs = {};

  @override
  AppState build() {
    // Precompute all possible dice pairs for each sum (2-12)
    for (var sum = 2; sum <= 12; sum++) {
      _sumToPairs[sum] = [];
      for (var d1 = 1; d1 <= 6; d1++) {
        for (var d2 = 1; d2 <= 6; d2++) {
          if (d1 + d2 == sum) {
            _sumToPairs[sum]!.add((d1, d2));
          }
        }
      }
    }

    return AppState.initial();
  }

  void _saveState() {
    state = state.copyWith(
      history: [...state.history, state.current],
    );
  }

  void undo() {
    if (state.history.isEmpty) return;
    state = state.copyWith(
      current: state.history.last,
      history: state.history.sublist(0, state.history.length - 1),
    );
  }

  void reset() {
    _saveState();
    state = state.copyWith(
      current: DiceState.initial().copyWith(
        equalDistribution: state.current.equalDistribution,
      ),
    );
  }

  void setEqualDistribution(bool value) {
    _saveState();
    state = state.copyWith(
      current: state.current.copyWith(
        equalDistribution: value,
      ),
    );
  }

  (int, int) _rollEqualDistributionPair() {
    // 1. Pick sum from 2-12 with equal probability
    final targetSum = 2 + _random.nextInt(11);
    // 2. Pick random pair that sums to target
    final possiblePairs = _sumToPairs[targetSum]!;
    return possiblePairs[_random.nextInt(possiblePairs.length)];
  }

  int _rollSingleDie() => 1 + _random.nextInt(6);

  void throwDice() {
    _saveState();
    final (die1, die2) = state.current.equalDistribution
        ? _rollEqualDistributionPair()
        : (_rollSingleDie(), _rollSingleDie());
    _updateState(die1, die2);
  }

  void throwDiceMultipleTimes(int count) {
    _saveState();
    var newState = state.current;
    final newSumFrequencies = Map<int, int>.from(newState.sumFrequencies);
    final newComboFrequencies = Map<(int, int), int>.from(newState.comboFrequencies);

    for (var i = 0; i < count; i++) {
      final (die1, die2) = newState.equalDistribution
          ? _rollEqualDistributionPair()
          : (_rollSingleDie(), _rollSingleDie());
      final sum = die1 + die2;
      final combo = (die1, die2);

      newSumFrequencies[sum] = (newSumFrequencies[sum] ?? 0) + 1;
      newComboFrequencies[combo] = (newComboFrequencies[combo] ?? 0) + 1;
    }

    state = state.copyWith(
      current: newState.copyWith(
        lastThrow: newState.lastThrow, // Maintain last throw
        totalThrows: newState.totalThrows + count,
        sumFrequencies: newSumFrequencies,
        comboFrequencies: newComboFrequencies,
      ),
    );
  }

  void _updateState(int die1, int die2) {
    final sum = die1 + die2;
    final combo = (die1, die2);

    state = state.copyWith(
      current: state.current.copyWith(
        lastThrow: combo,
        totalThrows: state.current.totalThrows + 1,
        sumFrequencies: {
          ...state.current.sumFrequencies,
          sum: (state.current.sumFrequencies[sum] ?? 0) + 1,
        },
        comboFrequencies: {
          ...state.current.comboFrequencies,
          combo: (state.current.comboFrequencies[combo] ?? 0) + 1,
        },
      ),
    );
  }

  int getMaxSumFrequency() {
    return state.current.sumFrequencies.values.maxOrNull ?? 1;
  }

  int getMaxComboFrequency() {
    return state.current.comboFrequencies.values.maxOrNull ?? 1;
  }
}

final diceProvider = NotifierProvider<DiceNotifier, AppState>(() {
  return DiceNotifier();
});