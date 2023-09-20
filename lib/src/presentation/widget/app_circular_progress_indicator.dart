import 'package:flutter/material.dart';
import '../../core/util/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Color(
        AppConstants.appFontColor,
      ),
    );
  }
}
