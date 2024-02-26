import 'dart:io';
import 'package:assignment/src/modules/random_dog/business/entities/random_dog_entity.dart';
import 'package:assignment/src/modules/random_dog/presentation/widgets/image_refresh.dart';
import 'package:flutter/material.dart';

class LocalImageView extends StatelessWidget {
  final RandomDogEntity? randomDog;
  final bool showButton;
  final VoidCallback onRefreshClicked;
  const LocalImageView({super.key, required this.randomDog, this.showButton = false, required this.onRefreshClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(showButton)
          ImageRefreshButton(onTap: onRefreshClicked),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(randomDog!.path!),
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.image_not_supported),
              );
            },
          ),
        ),
      ],
    );
  }
}
