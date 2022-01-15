import 'package:flutter/material.dart';

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        primary: Colors.white,
        onPrimary: Colors.deepOrange,
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
      onPressed: onClicked,
    );
