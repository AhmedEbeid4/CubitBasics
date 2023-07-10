import 'package:cubit_code_lab/domain/repository/repository.dart';
import 'package:cubit_code_lab/presentation/cubit/character_cubit.dart';


class FetchPageUseCase{
  Repository repository;
  FetchPageUseCase(this.repository);

  Future<CharactersUIState?> invoke(int page) async {
    return await repository.getNextPage(page);
  }
}