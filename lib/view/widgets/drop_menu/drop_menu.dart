import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropMenu extends StatelessWidget {
  const MyDropMenu({
    super.key,
    required this.bodyItems,
    required this.label,
    this.onChanged,
    this.value,
  });
  final List bodyItems;
  final String label;
  final String? value;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: value,
        hint: Text(
          label,
          style: context.textTheme.displaySmall,
        ),
        items: bodyItems
            .map(
              (sup) => DropdownMenuItem<String>(
                value: sup,
                child: Text(sup, style: context.textTheme.displaySmall),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
