part of 'character_cubit.dart';

enum CharacterPageStatus { loading, success, failure, internetIssue }


class CharactersUIState {
  CharacterPageStatus? status;
  List<Character>? data;
  String? message;
  int? numberOfPages = -1;
  int? currentPage = 0;


  factory CharactersUIState.success({List<Character>? data , int? numberOfPages}) {
    return CharactersUIState(
      status: CharacterPageStatus.success,
      data: data,
      numberOfPages: numberOfPages
    );
  }

  factory CharactersUIState.error(String error) {
    return CharactersUIState(
      status: CharacterPageStatus.failure,
      message: error,
    );
  }

  CharactersUIState(
      {this.status,
      this.data,
      this.message,
      this.numberOfPages,
      this.currentPage});
}
