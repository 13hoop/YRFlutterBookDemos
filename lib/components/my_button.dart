import 'package:flutter/material.dart';

class YRButton extends StatelessWidget {
  final Function()? onTap;

  const YRButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
        child: const Center(
          child: Text(
            '登 陆',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
