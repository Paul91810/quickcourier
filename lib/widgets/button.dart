import 'package:flutter/material.dart';
import 'package:quickcourier/core/constants/app_colors.dart';

class CustomAppElvatedButton extends StatelessWidget {
  const CustomAppElvatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backGroundcolor,
    this.disabledBackgroundColor,
    this.shape,
    this.buttonSize,
    this.bordersideColor,
  });

  final Widget child;
  final void Function() onPressed;
  final Color? backGroundcolor;
  final Color? disabledBackgroundColor;
  final OutlinedBorder? shape;
  final Size? buttonSize;
  final Color? bordersideColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: bordersideColor ?? Colors.transparent),
        disabledBackgroundColor: disabledBackgroundColor,
        backgroundColor: backGroundcolor ?? AppColors.lightSecondary,
        shape: shape,
        minimumSize: buttonSize ?? Size(double.infinity, 48),
      ),
      child:child
       
);
}
}
