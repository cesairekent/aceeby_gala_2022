import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget
{
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String btnText;
  final VoidCallback? onPressed;
  final double elevation;

  const BasicButton({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.btnText,
    this.elevation = 5.0,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(30.0),
      color: borderColor,
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
        ),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Text(
            btnText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.h7,
              ),
          ),
        ),
      ),
    );
  }
}
