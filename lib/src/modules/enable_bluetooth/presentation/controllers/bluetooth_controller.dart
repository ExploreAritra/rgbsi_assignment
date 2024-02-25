import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController{
  StreamSubscription? streamSubscription;
  static const platform = MethodChannel('assignment/bluetooth');
  static const eventChannel = EventChannel('assignment/bluetoothStatus');

  Rx<String> bluetoothStatus = Rx<String>("Waiting for bluetooth status");
  Rx<bool> bluetoothOn = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    streamSubscription = eventChannel
        .receiveBroadcastStream().listen((event) {
      bluetoothStatus.value = event;
      bluetoothOn.value = bluetoothStatus.value.contains("turned on") ? true : false;
    });
  }


  Future<void> turnOnBluetooth() async {
    bool state;
    if(Platform.isAndroid) {
      bluetoothStatus.value = "Turning on bluetooth...";
    }
    try {
      final result = await platform.invokeMethod<bool>('turnOnBluetooth');
      state = result ?? false;
      if(state && Platform.isAndroid) {
        bluetoothStatus.value = "Bluetooth is on";
      } else {
        bluetoothStatus.value = "Please enablecd bluetooth from settings";
      }
    } on PlatformException {
      state = false;
      if(Platform.isAndroid) {
        bluetoothStatus.value = "Bluetooth failed to turn on";
      } else {
        bluetoothStatus.value = "Error opening Settings";
      }
    }
  }

  Future<void> turnOffBluetooth() async {
    bool state;
    if(Platform.isAndroid) {
      bluetoothStatus.value = "Turning off bluetooth...";
    }
    try {
      final result = await platform.invokeMethod<bool>('turnOffBluetooth');
      state = result ?? false;
      if(state && Platform.isAndroid) {
        bluetoothStatus.value = "Bluetooth is off";
      } else {
        bluetoothStatus.value = "Please disable bluetooth from settings";
      }
    } on PlatformException {
      state = false;
      if(Platform.isAndroid) {
        bluetoothStatus.value = "Bluetooth failed to turn off";
      } else {
        bluetoothStatus.value = "Error opening Settings";
      }
    }
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}