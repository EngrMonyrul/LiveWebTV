import 'package:flutter/material.dart';
import '../consts/consts.dart';

PopupMenuItem<String> buildPopupMenuItem(BuildContext context, index) {
  return PopupMenuItem(
    value: '$index',
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: MediaQuery.sizeOf(context).width * 0.05,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        gradient: colorsList[index],
      ),
    ),
  );
}