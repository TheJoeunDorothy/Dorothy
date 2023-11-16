import 'package:flutter/cupertino.dart';

class SeasonTheme {
  final Color primaryColor;
  final Color onPrimaryColor;

  const SeasonTheme({required this.primaryColor, required this.onPrimaryColor});
  
  static const spring = SeasonTheme(
    primaryColor: Color(0xfff5e078), 
    onPrimaryColor: Color(0xFF6B5F1B)
  );
  
  static const summer = SeasonTheme(
    primaryColor: Color(0xff83cadd), 
    onPrimaryColor: Color(0xFF2B6678)
  );
  
  static const autumn = SeasonTheme(
    primaryColor: Color(0xFFEDAD8E), 
    onPrimaryColor: Color(0xFF843A16)
  );
  
  static const winter = SeasonTheme(
    primaryColor: Color(0xFFC6BFFA), 
    onPrimaryColor: Color(0xFF5B50AC)
  );
}
