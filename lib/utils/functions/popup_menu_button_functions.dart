import 'package:flutter/material.dart';
import 'package:livewebtv/utils/functions/popup_menu_items_function.dart';
import '../../controllers/providers/theme_provider.dart';
import '../consts/consts.dart';

PopupMenuButton<String> buildPopupMenuButton(BuildContext context, ThemeProvider property) {
  return PopupMenuButton<String>(
    splashRadius: 0.0,
    shadowColor: Colors.transparent,
    elevation: 0,
    color: Colors.transparent,
    constraints: BoxConstraints.tightFor(width: MediaQuery.sizeOf(context).width * 0.05),
    offset: const Offset(0, 30),
    onSelected: (value) {
      int index = int.parse(value);
      property.setColorIndex(index);
    },
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: MediaQuery.sizeOf(context).width * 0.05,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        gradient: colorsList[property.colorIndex],
      ),
    ),
    itemBuilder: (context) => <PopupMenuEntry<String>>[
      buildPopupMenuItem(context, 0),
      buildPopupMenuItem(context, 1),
      buildPopupMenuItem(context, 2),
      buildPopupMenuItem(context, 3),
      buildPopupMenuItem(context, 4),
      buildPopupMenuItem(context, 5),
      buildPopupMenuItem(context, 6),
      buildPopupMenuItem(context, 7),
      buildPopupMenuItem(context, 8),
      buildPopupMenuItem(context, 9),
      buildPopupMenuItem(context, 10),
      buildPopupMenuItem(context, 11),
    ],
  );
}
