import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged;
  const CustomCheckbox(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isChecked ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
              width: 1.5,
              color: isChecked ? AppColors.primaryColor : Color(0xffB1B1B1))),
      child: Checkbox(
          activeColor: AppColors.primaryColor,
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(width: 1.0, color: Colors.transparent),
          ),
          value: isChecked,
          onChanged: onChanged),
    );
  }
}
