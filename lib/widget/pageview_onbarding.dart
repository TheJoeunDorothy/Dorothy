import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel buildPage(BuildContext context, String imagePath, String text) {
  return PageViewModel(
    title: "",
    body: "",
    image: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(imagePath, fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
    decoration: const PageDecoration(
      fullScreen: true,
    ),
  );
}
