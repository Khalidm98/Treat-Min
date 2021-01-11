import 'package:flutter/material.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class ModalSheetListTile extends StatelessWidget {
  final String text;
  final bool value;
  final Function onSwitchChange;

  ModalSheetListTile(
      {@required this.text,
      @required this.value,
      @required this.onSwitchChange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      title: Text(text),
      trailing: GestureDetector(
        onTap: onSwitchChange,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 0),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomSwitchButton(
            checked: value,
            unCheckedColor: theme.primaryColorLight,
            checkedColor: Colors.white,
            animationDuration: Duration(milliseconds: 200),
            backgroundColor: value ? theme.primaryColorLight : Colors.white,
          ),
        ),
      ),
    );
  }
}
