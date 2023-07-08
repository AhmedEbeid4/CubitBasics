
import 'package:cubit_code_lab/data/network/api_service.dart';
import 'package:cubit_code_lab/data/repository/RepositoryImp.dart';
import 'package:cubit_code_lab/domain/repository/repository.dart';
import 'package:cubit_code_lab/domain/use_case/fetch_page_use_case.dart';
import 'package:cubit_code_lab/domain/use_case/get_all_use_case.dart';
import 'package:cubit_code_lab/presentation/ui/character_details_view.dart';
import 'package:cubit_code_lab/presentation/ui/characters_view.dart';
import 'package:cubit_code_lab/presentation/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/character_cubit.dart';

class AppRouter {
  late Repository repository;
  late GetAllUseCase getAllUseCase;
  late FetchPageUseCase fetchPageUseCase;
  late CharacterCubit characterCubit;

  AppRouter() {
    repository = RepositoryImp(ApiService());
    getAllUseCase = GetAllUseCase(repository);
    fetchPageUseCase = FetchPageUseCase(repository);
    characterCubit = CharacterCubit(allUseCase: getAllUseCase, fetchPageUseCase: fetchPageUseCase);
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutesNames.charactersRoute: (context) => BlocProvider(
          create: (context) {
            return characterCubit;
          },
          child: const CharactersView()),

      RoutesNames.characterDetailRoute : (context) => const CharacterDetailsView()

    };
  }
}
