import 'dart:io';
import 'package:assignment/src/modules/random_dog/business/entities/random_dog_entity.dart';
import 'package:flutter/material.dart';

class LocalImageView extends StatelessWidget {
  final RandomDogEntity? randomDog;
  const LocalImageView({super.key, required this.randomDog});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        File(randomDog!.path!),
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }
}
