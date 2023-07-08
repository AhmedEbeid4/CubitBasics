import 'package:cubit_code_lab/utils/extensions.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  late String id;
  late String name;
  late String status;
  late String imageUrl;

  CharacterItem({super.key,
    required this.id,
    required this.name,
    required this.status,
    required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Hero(
        tag: id,
        child: Row(
          children: [
            SizedBox(
                height: 70,
                width: 70,
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading_placeholder.gif',
                    image: imageUrl)),
            15.wi,
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(name), 8.he, Text(status)],
                ))
          ],
        ),
      ),
    );
  }
}
