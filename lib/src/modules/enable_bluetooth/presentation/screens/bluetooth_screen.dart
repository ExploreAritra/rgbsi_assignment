import 'package:assignment/src/core/utils/text_styles.dart';
import 'package:assignment/src/core/utils/ui_helpers.dart';
import 'package:assignment/src/core/widgets/button_widget.dart';
import 'package:assignment/src/modules/enable_bluetooth/presentation/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BluetoothScreen extends GetView<BluetoothController> {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text("Bluetooth Status", style: textStyles.h6TextStyle,),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bluetoothStatus(),
          verticalSpace_10,
          _bluetoothOnButton(),
          verticalSpace_10,
          _bluetoothOffButton(),
        ],
      ),
    );
  }

  Widget _bluetoothStatus() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: controller.bluetoothOn.value ? Colors.green : Colors.red,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text("Status: ${controller.bluetoothStatus.value}",
          style: textStyles.mdTextSemiBoldStyle.copyWith(color: Colors.white),),
      );
    });
  }

  Widget _bluetoothOnButton() {
    return ButtonWidget(
      title: "Turn On Bluetooth",
      onTap: () {
        controller.turnOnBluetooth();
      },
    );
  }

  Widget _bluetoothOffButton() {
    return ButtonWidget(
      title: "Turn Off Bluetooth",
      onTap: () {
        controller.turnOffBluetooth();
      },
    );
  }
}
