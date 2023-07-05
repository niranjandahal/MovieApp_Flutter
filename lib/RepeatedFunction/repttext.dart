import 'package:flutter/material.dart';

Widget tittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
          color: Colors.white.withOpacity(0.9),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget boldtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget normaltext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25));
}

Widget datetext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ratingtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ultratittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'open sans',
          color: Colors.white.withOpacity(0.9),
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget genrestext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25));
}

Widget overviewtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.25));
}

Widget Tabbartext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(1),
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1));
}
