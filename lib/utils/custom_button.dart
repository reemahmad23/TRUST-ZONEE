import 'package:flutter/material.dart';
import 'package:trust_zone/utils/values_managers.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressedAction;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final IconData? icon; // ✅ الأيقونة الاختيارية

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressedAction,
    required this.backgroundColor,
    required this.textColor,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding ?? const EdgeInsets.symmetric(vertical: AppSize.s16, horizontal: AppSize.s32),
        minimumSize: Size(width ?? double.infinity, height ?? AppSize.s50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s20),
        ),
      ),
      onPressed: onPressedAction,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: fontSize ?? AppSize.s18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? AppSize.s18,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
