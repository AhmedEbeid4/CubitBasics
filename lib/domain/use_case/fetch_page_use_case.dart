import 'package:cubit_code_lab/domain/model/character.dart';
import 'package:cubit_code_lab/domain/repository/repository.dart';

import '../../utils/data_status.dart';

class FetchPageUseCase{
  Repository repository;
  FetchPageUseCase(this.repository);

  Future<List<Character>?> invoke(int page, Function(String message) onFail) async {
    final res = await repository.getNextPage(page);
    switch(res.status){
      case Status.success:
        return res.data;
      case Status.fail:
        onFail(res.message.toString());
      default:
        return null;
    }
    return null;
  }
}