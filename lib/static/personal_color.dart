import 'package:flutter/cupertino.dart';

class SeasonTheme {
  final Color backgroundColor;
  final Color foregroundColor;

  const SeasonTheme({required this.backgroundColor, required this.foregroundColor});
  
  static const spring = SeasonTheme(
    backgroundColor: Color(0xFFDDA29C),
    foregroundColor: Color(0xFFAD1100),
  );
  
  static const summer = SeasonTheme(
    backgroundColor: Color(0xFF8EABDE), 
    foregroundColor: Color(0xFF003FB4), 
  );
  
  static const autumn = SeasonTheme(
    backgroundColor: Color(0xFFAB8D59), 
    foregroundColor: Color(0xFF6C4400), 
  );
  
  static const winter = SeasonTheme(
    backgroundColor: Color(0xFFC74696), 
    foregroundColor: Color(0xFF5B0038), 
  );
}
