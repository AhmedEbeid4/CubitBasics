import 'dart:convert';

import 'package:cubit_code_lab/data/network/api_constants.dart';
import 'package:cubit_code_lab/domain/model/character.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getCharacters() async {
    try {
      final response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.allCharactersEndPoint));
      print('DATA : response : $response');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('DATA : result : $result');
        int pages = result["info"]["pages"];
        print('DATA : pages : $pages');
        List<Character> list = [];
        final resultsList = result["results"] as List;
        for (var element in resultsList) {
          list.add(Character.fromJson(element));
        }
        print('DATA : list : $list');

        return returnResponse(
            response: response,
            data: {"pages": pages, "resultsList": list});
      } else {
        return returnResponse(response: response);
      }
    }on Exception catch(e) {
      return e;
    }
  }

  Future<dynamic> getPage(int page) async {
    try {
      final params = {ApiConstants.pageParameter: '$page'};
      final response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.allCharactersEndPoint)
              .replace(queryParameters: params));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<Character> list = [];
        final resultsList = result["results"] as List;
        for (var element in resultsList) {
          list.add(Character.fromJson(element));
        }
        return returnResponse(response: response, data: list);
      } else {
        return returnResponse(response: response);
      }
    }on Exception catch(e){
      return e;
    }
  }

  dynamic returnResponse({required http.Response response, dynamic data}) {
    switch (response.statusCode) {
      case 200:
        return data;
      default:
        return response.statusCode;
    }
  }
}
