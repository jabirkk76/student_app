// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/add_student_controller.dart';

class DropDownFormFieldWidget extends StatelessWidget {
  DropDownFormFieldWidget({
    Key? key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  String? hint;
  String? value;
  List<DropdownMenuItem<String>>? items;
  void Function(String?)? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddStudentController>(
      builder: (context, controller, child) {
        return DropdownButtonFormField<String>(
          hint: Text(hint ?? ''),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: value,
          items: items,
          onChanged: onTap,
          validator: (value) {
            if (value == null) {
              return 'Enter Valid Credential';
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}
