import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../widgets/actions/bla_icon_button.dart';

class RidePrefsInputTile extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData leftIcon;
  final bool isPlaceholder;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefsInputTile({
    super.key,
    required this.title,
    this.onPressed,
    required this.leftIcon,
    this.isPlaceholder = false,
    this.rightIcon,
    this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = isPlaceholder
        ? BlaColors.textLight
        : BlaColors.textNormal;
    return ListTile(
      onTap: onPressed,
      leading: Icon(leftIcon, size: 16, color: BlaColors.iconLight),
      title: Text(title, style: BlaTextStyles.body.copyWith(color: textColor)),
      trailing: BlaIconButton(icon: rightIcon, onPressed: onRightIconPressed),
    );
  }
}
