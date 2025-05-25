import '../models/dice_state.dart';

class AppState {
  final List<DiceState> history;
  final DiceState current;

  AppState({
    required this.history,
    required this.current,
  });

  AppState copyWith({
    List<DiceState>? history,
    DiceState? current,
  }) {
    return AppState(
      history: history ?? this.history,
      current: current ?? this.current,
    );
  }

  factory AppState.initial() {
    return AppState(
      history: [],
      current: DiceState.initial(),
    );
  }
}