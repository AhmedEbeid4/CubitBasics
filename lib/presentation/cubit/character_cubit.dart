import 'package:bloc/bloc.dart';
import 'package:cubit_code_lab/domain/use_case/fetch_page_use_case.dart';
import 'package:meta/meta.dart';

import '../../domain/model/character.dart';
import '../../domain/use_case/get_all_use_case.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharactersPageState> {
  final GetAllUseCase allUseCase;
  final FetchPageUseCase fetchPageUseCase;
  List<Character>? characters;
  int numberOfPages = -1;
  int currentPage = 0;

  bool get end {
    return numberOfPages <= currentPage;
  }

  CharacterCubit({required this.allUseCase, required this.fetchPageUseCase})
      : super(CharactersPageState());

  void fetchData() {
    emit(CharactersPageState(characterPageStatus: CharacterPageStatus.loading));
    allUseCase.invoke((message) {
      if (message == "Internet Connection Error") {
        emit(CharactersPageState(
            characterPageStatus: CharacterPageStatus.internetIssue,
            message: message));
      } else {
        emit(CharactersPageState(
            characterPageStatus: CharacterPageStatus.failure,
            message: message));
      }
    }).then((value) {
      if (value != null) {
        characters = value[1];
        numberOfPages = value[0];
        currentPage = 1;
        emit(CharactersPageState(
            characterPageStatus: CharacterPageStatus.success,
            characters: characters,
            numberOfPages: numberOfPages,
            currentPage: currentPage));
      }
    });
  }

  void findNextPage() {
    print('HEEELLO');
    print('CURR_PAGE : $currentPage , PAGES_NUM : $numberOfPages');
    print('CURR_PAGE : ${state.currentPage} , PAGES_NUM : ${state.numberOfPages}');
    if (end) return;
    fetchPageUseCase.invoke(currentPage+1, (message) => {

    }).then((value) {
      if(value!= null){
        for (var element in value) {
          print(element.name);}

        currentPage++;
        characters!.addAll(value);
        emit(CharactersPageState(
            characterPageStatus: CharacterPageStatus.success,
            characters: characters,
            numberOfPages: numberOfPages,
            currentPage: currentPage));
      }
    });
  }
}
