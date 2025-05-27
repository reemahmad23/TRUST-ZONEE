import 'package:flutter/material.dart';
import 'package:trust_zone/utils/values_managers.dart';


import 'color_managers.dart';

abstract class AppStyles {
  static const TextStyle styleBold24 = TextStyle(
    color: Color(0xFF1B4965),
    fontSize: 24,
    fontFamily: 'Alef',
    fontWeight: FontWeight.w700,
  );

  static TextStyle subText = TextStyle(
    color: ColorManager.white,
    fontSize: AppSize.s16,
    fontFamily: 'Alef',
    fontWeight: FontWeight.w700,
  );
  static TextStyle regular1 = TextStyle(
    color: ColorManager.white,
    fontSize: AppSize.s32,
    fontFamily: 'Alef',
    fontWeight: FontWeight.w700,
  );

  static TextStyle styleSemiBold24 = TextStyle(
    color:ColorManager.primary ,
    fontSize: AppSize.s24,
    fontFamily: 'Alef',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle styleBold = TextStyle(
    color: Color(0xFF1B4965),
    fontSize: AppSize.s24,
    fontFamily: 'Alef',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle styleRegular16 = TextStyle(
    color: Color(0xFF2B2B2B),
    fontSize: AppSize.s16,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleRegular13 = TextStyle(
    color: Color(0xFF656565),
    fontSize: 13,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle styleSemiBold14 = TextStyle(
    color: Color(0xFF656565),
    fontSize: 14,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle styleBold14 = TextStyle(
    color: Color(0xFF656565),
    fontSize: 14,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle styleBold16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle styleSemiBold16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w600,
  );




}