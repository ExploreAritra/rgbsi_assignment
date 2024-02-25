import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:assignment/src/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonWidget(
            title: "Random Dog",
            onTap: (){
              Get.toNamed(RouteConstants.randomDogScreen);
            },
          ),
          ButtonWidget(
            title: "Bluetooth Status",
            onTap: (){
              Get.toNamed(RouteConstants.bluetoothScreen);
            },
          ).paddingOnly(top: 20),
          ButtonWidget(
            title: "Random User",
            onTap: (){
              Get.toNamed(RouteConstants.randomUserScreen);
            },
          ).paddingOnly(top: 20),
        ],
      ),
    );
  }

}
