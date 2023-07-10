import 'package:cubit_code_lab/presentation/cubit/character_cubit.dart';
import 'package:cubit_code_lab/presentation/ui/routes/route_names.dart';
import 'package:cubit_code_lab/presentation/ui/widgets/character_item.dart';
import 'package:cubit_code_lab/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../domain/model/character.dart';

class CharactersView extends StatelessWidget {
  CharactersView({super.key});

  List<Character>? characters;

  final _scrollController = ScrollController();

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget internetConnectionIssue() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.signal_wifi_connected_no_internet_4_sharp,
            size: 90,
          ),
          5.he,
          const Text("No Internet Connection")
        ],
      ),
    );
  }

  Widget listItems(List<Character> list, BuildContext context) {
    final end = context.read<CharacterCubit>().end;
    return ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final currItem = list[index];
          if (index < list.length) {
            return InkWell(
              onTap: () => context.pushNamed(RoutesNames.characterDetailRoute,
                  arguments: currItem),
              child: CharacterItem(
                id: '${currItem.id}',
                name: currItem.name,
                status: currItem.status,
                imageUrl: currItem.imageUrl,
              ),
            );
          }
          return end
              ? const SizedBox()
              : const Center(child: CircularProgressIndicator());
        });
  }

  Widget blocWidget() {
    return BlocBuilder<CharacterCubit, CharactersUIState>(
      builder: (context, state) {
        switch (state.status) {
          case CharacterPageStatus.success:
            return listItems(state.data!, context);
          case CharacterPageStatus.internetIssue:
            return internetConnectionIssue();
          case CharacterPageStatus.failure:
            return Text(state.message.toString());
          default:
            return loading();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _onScroll(context);
    });
    final cubit = BlocProvider.of<CharacterCubit>(context);
    Future.delayed(Duration.zero, () {
      cubit.fetchData();
    });
    return Scaffold(
        appBar: AppBar(),
        body: OfflineBuilder(
          connectivityBuilder: (context, connectivity, child) {
            if (connectivity != ConnectivityResult.none) {
              return child;
            } else {
              return internetConnectionIssue();
            }
          },
          child: blocWidget(),
        ));
  }

  void _onScroll(BuildContext context) {
    if (_isBottom) {
      context.read<CharacterCubit>().findNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }
}
