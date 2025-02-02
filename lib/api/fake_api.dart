import 'package:test/model/response_model.dart';

class FakeApi {
  Future<List<ResponseModel>> getResponse() async {
    await Future.delayed(const Duration(seconds: 1));
    return mock;
  }
}
