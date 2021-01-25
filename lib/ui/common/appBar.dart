import 'package:flutter/material.dart';

TransparentAppBar(BuildContext context, {String title}) => AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: title == null? SizedBox() : Text(title, style: Theme.of(context).textTheme.headline6,),
  iconTheme: IconThemeData(
    color: Theme.of(context).brightness == Brightness.dark? Colors.white : Colors.black
  ),
);