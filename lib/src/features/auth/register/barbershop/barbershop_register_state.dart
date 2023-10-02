enum BarbershopRegisterStateStatus { initial, successful, failure }

class BarbershopRegisterState {
  final List<String> openingDays;
  final List<int> openingHours;
  final BarbershopRegisterStateStatus status;

  BarbershopRegisterState({
    required this.openingDays,
    required this.openingHours,
    required this.status,
  });

  BarbershopRegisterState.initial()
      : this(
          openingDays: <String>[],
          openingHours: <int>[],
          status: BarbershopRegisterStateStatus.initial,
        );

  BarbershopRegisterState copyWith({
    List<String>? openingDays,
    List<int>? openingHours,
    BarbershopRegisterStateStatus? status,
  }) {
    return BarbershopRegisterState(
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
      status: status ?? this.status,
    );
  }
}
