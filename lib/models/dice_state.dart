class DiceState {
  final (int, int) lastThrow;
  final int totalThrows;
  final bool equalDistribution;
  final Map<int, int> sumFrequencies;
  final Map<(int, int), int> comboFrequencies;

  DiceState({
    required this.lastThrow,
    required this.totalThrows,
    required this.equalDistribution,
    required this.sumFrequencies,
    required this.comboFrequencies,
  });

  DiceState copyWith({
    (int, int)? lastThrow,
    int? totalThrows,
    bool? equalDistribution,
    Map<int, int>? sumFrequencies,
    Map<(int, int), int>? comboFrequencies,
  }) {
    return DiceState(
      lastThrow: lastThrow ?? this.lastThrow,
      totalThrows: totalThrows ?? this.totalThrows,
      equalDistribution: equalDistribution ?? this.equalDistribution,
      sumFrequencies: sumFrequencies ?? this.sumFrequencies,
      comboFrequencies: comboFrequencies ?? this.comboFrequencies,
    );
  }

  factory DiceState.initial() {
    return DiceState(
      lastThrow: (1, 1),
      totalThrows: 0,
      equalDistribution: false,
      sumFrequencies: {},
      comboFrequencies: {},
    );
  }
}