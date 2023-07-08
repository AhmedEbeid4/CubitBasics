import 'dart:async';

import 'package:cubit_code_lab/data/network/api_service.dart';
import 'package:cubit_code_lab/domain/model/character.dart';
import 'package:cubit_code_lab/domain/repository/repository.dart';
import 'package:cubit_code_lab/utils/data_status.dart';

// TimeoutException

class RepositoryImp extends Repository {
  final ApiService _apiService;

  RepositoryImp(this._apiService);

  @override
  Future<DataStatus<dynamic>> getFirstPage() async {
    try {
      final res = await _apiService.getCharacters();
      print('DATA: $res');
      if (res is Map<String, dynamic>) {
        return DataStatus.success(res);
      } else {
        if (res is int) {
          return returnDataStatusWithCode(res);
        } else {
          return DataStatus.error("Internet Connection Error");
        }
      }
    } on Exception catch (e) {
      return DataStatus.error(e.toString());
    }
  }

  @override
  Future<DataStatus<dynamic>> getNextPage(int page) async {
    try {
      final res = await _apiService.getPage(page);
      print('DATA: $res');
      if (res is List<Character>) {
        return DataStatus.success(res);
      } else {
        if (res is int) {
          return returnDataStatusWithCode(res);
        } else {
          return DataStatus.error("Internet Connection Error");
        }
      }
    } on Exception catch (e) {
      return DataStatus.error(e.toString());
    }
  }

  DataStatus returnDataStatusWithCode(int code) {
    switch (code) {
      case 500:
        return DataStatus.error("Internal Server Error");
      case 400:
        return DataStatus.error("400 Bad Request");
      default:
        return DataStatus.error(
            "Error occurred while communicating with server with status code $code");
    }
  }
}
