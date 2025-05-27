import 'dart:ui';

abstract class ColorManager {
  static const Color primary = Color(0xff1B4965);
  static const Color mintGreen = Color(0xffBEE9E8);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color error = Color(0xffe61f34);
  static const Color darkGrey = Color(0xff1B4965);

  // New colors extracted from the profile page
  static final Color lightGrey = const Color(0xFFD6D6D6); // Approx. grey.shade300
  static final Color extraLightGrey = const Color(0xFFFAFAFA); // Approx. grey.shade50
  static final Color shadowGrey = const Color(0x1A000000); // black.withOpacity(0.1)
  static final Color mediumBlackOpacity = const Color(0x40000000); // black.withOpacity(0.25)
  static final Color lightBlackOpacity = const Color(0x0D000000); // black.withOpacity(0.05)
  static final Color blackShadow = const Color(0x33000000); // black.withOpacity(0.2)
  static final Color lightBlueBackground = Color(0xFFE3F2FD); // Approx. blue.shade50
}
