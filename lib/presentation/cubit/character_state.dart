part of 'character_cubit.dart';

enum CharacterPageStatus { loading, success, failure, internetIssue }

@immutable
abstract class CharacterState {}


class CharactersPageState extends CharacterState {
  CharacterPageStatus? characterPageStatus;
  List<Character>? characters;
  String? message;
  int? numberOfPages = -1;
  int? currentPage = 0;

  bool get end {
    return numberOfPages == currentPage;
  }

  CharactersPageState(
      {this.characterPageStatus, this.characters, this.message, this.numberOfPages, this.currentPage});
}
