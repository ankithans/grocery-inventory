import 'package:flutter/material.dart';
const Color primaryColor = Color(0XFE07BEB8);
const Color backgroundColor = Color(0XFEeff7f6);

const api = 'https://grocery-invent.herokuapp.com';

AppBar titleAppbar(context,
    {@required String title,
    List<Widget> actions,
    bool automaticallyImplyLeading = true,
    bool centerTitle = false,
    Widget leading}) {
  return AppBar(
    backgroundColor: primaryColor,
    elevation: 0,
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    actions: actions != null ? actions : null,
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$title",
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontSize: 20.0
        )
      ),
    ),
  );
}