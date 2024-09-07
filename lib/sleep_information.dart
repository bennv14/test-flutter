class SleepInformation {
  final DateTime dateSleep;
  final SleepQuantityLevel? sleepQuantityLevel;
  final SleepForecastLevel? sleepForecastLevel;

  SleepInformation({
    required this.dateSleep,
    this.sleepQuantityLevel,
    this.sleepForecastLevel,
  });
}

class SleepQuantityLevel {
  SleepQuantityLevel._();

  final int veryBad = 1;
  final int bad = 2;
  final int normal = 3;
  final int good = 4;
  final int excellent = 5;
}

class SleepForecastLevel {
  SleepForecastLevel._();

  final int veryBad = 1;
  final int bad = 2;
  final int normal = 3;
  final int good = 4;
  final int excellent = 5;
}
