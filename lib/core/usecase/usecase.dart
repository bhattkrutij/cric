import '../../data/auth/models/base_response_model.dart';

abstract class UseCase<T,Params> {
  Future<T> call({Params params});
}