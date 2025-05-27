import 'package:flutter/cupertino.dart';
import 'package:trust_zone/utils/color_managers.dart';

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoRow ({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20,color: ColorManager.primary,),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}