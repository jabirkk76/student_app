import 'package:flutter/material.dart';

class DismissKeyboardWidget extends StatelessWidget {
  const DismissKeyboardWidget({Key? key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentTextFieldFocus = FocusScope.of(context);
        if (!currentTextFieldFocus.hasPrimaryFocus &&
            currentTextFieldFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
