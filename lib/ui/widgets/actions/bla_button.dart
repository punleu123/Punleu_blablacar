import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;
  const BlaButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.type,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = type == BlaButtonType.primary
        ? BlaColors.primary
        : BlaColors.white;
    BorderSide borderSide = type == BlaButtonType.primary
        ? BorderSide.none
        : BorderSide(color: BlaColors.neutralLight, width: 2);
    Color textColor = type == BlaButtonType.primary
        ? BlaColors.white
        : BlaColors.primary;

    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, color: textColor));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    Text buttonText = Text(
      text,
      style: BlaTextStyles.button.copyWith(color: textColor),
    );
    children.add(buttonText);

    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
