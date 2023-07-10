import 'dart:async';

import 'package:cubit_code_lab/data/network/api_service.dart';
import 'package:cubit_code_lab/domain/model/character.dart';
import 'package:cubit_code_lab/domain/repository/repository.dart';
import 'package:cubit_code_lab/presentation/cubit/character_cubit.dart';

// TimeoutException

class RepositoryImp extends Repository {
  final ApiService _apiService;

  RepositoryImp(this._apiService);

  @override
  Future<CharactersUIState> getFirstPage() async {
    try {
      final res = await _apiService.getCharacters();
      print('DATA: $res');
      if (res is Map<String, dynamic>) {
        return CharactersUIState.success(
          numberOfPages: res["pages"],
          data: res["resultsList"]
        );
      } else {
        if (res is int) {
          return _returnDataStatusWithCode(res);
        } else {
          return CharactersUIState.error("Internet Connection Error");
        }
      }
    } on Exception catch (e) {
      return CharactersUIState.error(e.toString());
    }
  }

  @override
  Future<CharactersUIState> getNextPage(int page) async {
    try {
      final res = await _apiService.getPage(page);
      print('DATA: $res');
      if (res is List<Character>) {
        return CharactersUIState.success(data: res);
      } else {
        if (res is int) {
          return _returnDataStatusWithCode(res);
        } else {
          return CharactersUIState.error("Internet Connection Error");
        }
      }
    } on Exception catch (e) {
      return CharactersUIState.error(e.toString());
    }
  }

  CharactersUIState _returnDataStatusWithCode(int code) {
    switch (code) {
      case 500:
        return CharactersUIState.error("Internal Server Error");
      case 400:
        return CharactersUIState.error("400 Bad Request");
      default:
        return CharactersUIState.error("Error occurred while communicating with server with status code $code");
    }
  }
}
