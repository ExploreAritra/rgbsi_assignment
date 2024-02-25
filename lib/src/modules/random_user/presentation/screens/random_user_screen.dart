import 'package:assignment/src/core/utils/text_styles.dart';
import 'package:assignment/src/core/widgets/button_widget.dart';
import 'package:assignment/src/modules/random_user/presentation/widgets/employee_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/random_user_controller.dart';

class RandomUserScreen extends GetView<RandomUserController> {
  const RandomUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _refreshButton(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text("Random User", style: textStyles.h6TextStyle,),
    );
  }

  Widget _body() {
    return Center(
      child: Obx(() {
        if(controller.isLoading.value) {
          return const CircularProgressIndicator();
        }
        return EmployeeCard(user: controller.randomUser.value?.results?.first,);
      },
      ).marginAll(20),
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

