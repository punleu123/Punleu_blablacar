import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class BlaIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const BlaIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(icon, size: 24, color: BlaColors.primary),
        ),
      ),
    );
  }
}
