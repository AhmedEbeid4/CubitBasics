import 'package:cubit_code_lab/presentation/cubit/character_cubit.dart';
import 'package:cubit_code_lab/presentation/ui/widgets/character_item.dart';
import 'package:cubit_code_lab/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/character.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  List<Character>? characters;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final cubit = BlocProvider.of<CharacterCubit>(context);
    cubit.fetchData();
  }

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

  Widget listItems(List<Character> list) {
    final end = context.read<CharacterCubit>().state.end;
    return ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final currItem = list[index];
          if (index < list.length) {
            return CharacterItem(
              name: currItem.name,
              status: currItem.status,
              imageUrl: currItem.imageUrl,
            );
          }
          return end
              ? const SizedBox()
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<CharacterCubit, CharactersPageState>(
        builder: (context, state) {
          switch (state.characterPageStatus) {
            case CharacterPageStatus.success:
              return listItems(state.characters!);
            case CharacterPageStatus.internetIssue:
              return internetConnectionIssue();
            case CharacterPageStatus.failure:
              return Text(state.message.toString());
            default:
              return loading();
          }
        },
      ),
    ));
  }

  void _onScroll() {
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