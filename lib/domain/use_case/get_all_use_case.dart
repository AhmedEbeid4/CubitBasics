
import '../../presentation/cubit/character_cubit.dart';
import '../repository/repository.dart';

class GetAllUseCase{
  final Repository _repository;

  GetAllUseCase(this._repository);

  Future<CharactersUIState?> invoke(Function(String message) onFail) async {
    final res = await _repository.getFirstPage();
    return res;
  }
}