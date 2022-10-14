import 'package:flutter/material.dart';

class BuildIconButton{
 static IconButton buildIconButton({required IconData icon,required VoidCallback function, Color color=Colors.white}) {
    return IconButton(
        icon:  Icon(icon,
        color: color,
        ),
        onPressed: function);
  }
}