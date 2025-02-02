part of 'test_bloc.dart';

class TestState extends Equatable {
  final bool isLoading;
  final List<ResponseModel> data;

  const TestState({
    this.isLoading = false,
    this.data = const [],
  });

  TestState copyWith({
    bool? isLoading,
    List<ResponseModel>? data,
  }) {
    return TestState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, data];
}
