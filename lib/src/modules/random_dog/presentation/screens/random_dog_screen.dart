
import 'package:assignment/src/core/utils/text_styles.dart';
import 'package:assignment/src/core/widgets/app_bar.dart';
import 'package:assignment/src/core/widgets/button_widget.dart';
import 'package:assignment/src/modules/random_dog/presentation/widgets/local_image_view.dart';
import 'package:assignment/src/modules/random_dog/presentation/widgets/remote_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/random_dog_controller.dart';

class RandomDogScreen extends GetView<RandomDogController> {
  const RandomDogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Random Dog",),
      body: _body(),
      bottomNavigationBar: _refreshButton(),
    );
  }


  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              if(controller.isLoading.value) {
                return const CircularProgressIndicator();
              }
              if(controller.randomDog.value?.path != null) {
                return LocalImageView(randomDog: controller.randomDog.value,);
              }
              return RemoteImageView(randomDog: controller.randomDog.value,);
            },
            ).marginAll(20),
          ],
        ),
      ),
    );
  }

  Widget _refreshButton() {
    return ButtonWidget(
      title: "Refresh",
      onTap: () {
        controller.refreshData();
      },
    ).marginAll(20);
  }
}

