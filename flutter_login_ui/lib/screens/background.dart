import 'package:flutter/material.dart';

Widget buildBackground(){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blueGrey[600],
          Colors.blueGrey[700],
          Colors.blueGrey[800],
          Colors.blueGrey[900],
        ],
        stops: [0.1, 0.4, 0.7, 0.9],
      ),
    ),
  );
}