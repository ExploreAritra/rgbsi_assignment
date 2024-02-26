import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageRefreshButton extends StatelessWidget {
  final VoidCallback onTap;
  const ImageRefreshButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      shape: const CircleBorder(),
      color: Colors.black54,
      child: const Icon(Icons.refresh, color: Colors.white70,),
    ).marginOnly(bottom: 15);
  }
}
