import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel buildPage(
    BuildContext context, String imagePath, String titleText, String text) {
  return PageViewModel(
    title: titleText,
    body: text,
    image: Image.asset(imagePath, fit: BoxFit.fill),
  );
}
