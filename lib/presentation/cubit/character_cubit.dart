import 'package:bloc/bloc.dart';
import 'package:cubit_code_lab/domain/use_case/fetch_page_use_case.dart';
import 'package:meta/meta.dart';

import '../../domain/model/character.dart';
import '../../domain/use_case/get_all_use_case.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharactersUIState> {
  final GetAllUseCase allUseCase;
  final FetchPageUseCase fetchPageUseCase;
  List<Character>? characters;
  int numberOfPages = -1;
  int currentPage = 0;

  bool get end {
    return numberOfPages <= currentPage;
  }

  CharacterCubit({required this.allUseCase, required this.fetchPageUseCase})
      : super(CharactersUIState());

  void fetchData() {
    emit(CharactersUIState(status: CharacterPageStatus.loading));
    allUseCase.invoke((message) {
      if (message == "Internet Connection Error") {
        emit(CharactersUIState(
            status: CharacterPageStatus.internetIssue,
            message: message));
      } else {
        emit(CharactersUIState(
            status: CharacterPageStatus.failure,
            message: message));
      }
    }).then((value) {
      if (value != null) {
        characters = value.data;
        numberOfPages = value.numberOfPages!;
        currentPage = 1;
        emit(CharactersUIState(
            status: CharacterPageStatus.success,
            data: characters));
      }
    });
  }

  void findNextPage() {
    print('CURR_PAGE : $currentPage , PAGES_NUM : $numberOfPages');
    if (end) return;
    fetchPageUseCase.invoke(currentPage + 1).then((value) {
      print('12 CURR_PAGE : $currentPage , PAGES_NUM : $numberOfPages');
      if (value != null) {
        print('123 CURR_PAGE : $currentPage , PAGES_NUM : $numberOfPages');

        currentPage++;
        characters!.addAll(value.data!);
        value.currentPage = currentPage;
        value.data = characters!;
        emit(value);
      }
    });
  }
}
