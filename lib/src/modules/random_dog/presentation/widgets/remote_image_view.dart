import 'package:assignment/src/modules/random_dog/business/entities/random_dog_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class RemoteImageView extends StatelessWidget {
  final RandomDogEntity? randomDog;
  const RemoteImageView({super.key, required this.randomDog});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        randomDog?.message ?? "",
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) {
            return child;
          }
          return const CircularProgressIndicator().marginAll(20);
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }
}
