
import 'package:dropikme001/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';




class LoadingLayout extends StatelessWidget {
  const LoadingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.02),
      padding: const EdgeInsets.all(130),
      child: Center(
        child: LoadingIndicator(

          indicatorType: Indicator.ballRotateChase,
          colors: Appcolors().rainbowColors,
          strokeWidth: 4.0,
          pathBackgroundColor: Colors.black.withOpacity(0.05),
        ),
      ),
    );
  }
}
