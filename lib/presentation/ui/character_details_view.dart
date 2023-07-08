import 'package:flutter/material.dart';

import '../../domain/model/character.dart';

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key});

  Widget appBar(Character character) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.black),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
        body: CustomScrollView(
      slivers: [appBar(character)],
    ));
  }
}
