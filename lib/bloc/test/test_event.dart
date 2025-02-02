part of 'test_bloc.dart';

class TestEvent {
  const TestEvent();
  factory TestEvent.fetch(BuildContext context) = _Fetch;
}

class _Fetch extends TestEvent {
  BuildContext context;
  _Fetch(this.context);
}
