import 'package:flutter/material.dart';

/*
  Main color palette class of the entire application
  This follows the 60% - 30% - 10% rule of UI/UX Design

  The main color will follow the business's color theme

  Business: Davao del Norte State College
  Color Theme: Green

  Color palette hex codes copied from Figma:

  Main Colors:
    Primary = #E9EBED
    Secondary = #3AB67D
    Accent = #13714C

  Text Colors (But they can be use not just for text)
    DarkShadePrimary = #353535
    DarkShadeSecondary = #848484
    LightShadePrimary = #FFFFFF
    LightShadeSecondary = #EEEEEE
*/

class Palette {
  // Main colors
  static const Color primaryColor = Color.fromRGBO(233, 235, 237, 1);
  static const Color secondaryColor = Color.fromRGBO(58, 182, 125, 1);
  static const Color accentColor = Color.fromRGBO(19, 113, 76, 1);
  static const Color darkGreenColor = Color.fromRGBO(6, 26, 0, 1);

  // Text or Supplementary Colors
  static const Color darkShadePrimary = Color.fromRGBO(53, 53, 53, 1);
  static const Color darkShadeSecondary = Color.fromRGBO(132, 132, 132, 1);
  static const Color lightShadePrimary = Color.fromRGBO(255, 255, 255, 1);
  static const Color lightShadeSecondary = Color.fromRGBO(238, 238, 238, 1);
}
