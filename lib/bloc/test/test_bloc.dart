import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/api/fake_api.dart';
import 'package:test/cache/cache_manager.dart';
import 'package:test/model/response_model.dart';
import 'package:test/second_screen.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(const TestState()) {
    on<_Fetch>(_onFetch);
  }

  Future<void> _onFetch(_Fetch event, Emitter<TestState> emit) async {
    emit(state.copyWith(isLoading: true));
    final data = await FakeApi().getResponse();
    emit(state.copyWith(isLoading: false, data: data));
    Navigator.of(event.context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SecondScreen(),
      ),
    );
    _preCacheFiles(data.map((e) => e.file.url));
  }

  Future<void> _preCacheFiles(Iterable<String> urls) async {
    for (final url in urls) {
      try {
        await CacheManager.downloadFile(url);
      } catch (e) {
        continue;
      }
    }
  }
}
