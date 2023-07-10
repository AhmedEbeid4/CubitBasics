import 'package:cubit_code_lab/presentation/cubit/character_cubit.dart';

abstract class Repository{
  Future<CharactersUIState> getFirstPage();
  Future<CharactersUIState> getNextPage(int page);
}