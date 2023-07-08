
import '../../utils/data_status.dart';
import '../model/character.dart';
import '../repository/repository.dart';

class GetAllUseCase{
  final Repository _repository;

  GetAllUseCase(this._repository);

  Future<List?> invoke(Function(String message) onFail) async {
    final res = await _repository.getFirstPage();
    switch(res.status){
      case Status.success:
        return [res.data["pages"], res.data["resultsList"] as List<Character>];
      case Status.fail:
        onFail(res.message.toString());
      default:
        return null;
    }
    return null;
  }
}