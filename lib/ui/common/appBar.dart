import 'package:flutter/material.dart';

TransparentAppBar(BuildContext context) => AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: IconThemeData(
    color: Theme.of(context).brightness == Brightness.dark? Colors.white : Colors.black
  ),
);