import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPanel extends StatelessWidget {
  final String message;
  const LoadingPanel({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitFadingCircle(color: Colors.indigo, size: 60.0),
          const SizedBox(height: 20),
          Text(message, style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}