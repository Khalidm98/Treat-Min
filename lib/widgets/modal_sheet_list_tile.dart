import 'package:flutter/material.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class ModalSheetListTile extends StatefulWidget {
  final String text;
  bool val;

  ModalSheetListTile({@required this.text, @required this.val});
  @override
  _ModalSheetListTileState createState() => _ModalSheetListTileState();
}

class _ModalSheetListTileState extends State<ModalSheetListTile> {
  @override
  Widget build(BuildContext context) {
    void onSwitchChange() {
      setState(() {
        widget.val = !widget.val;
      });
    }

    return ListTile(
      dense: true,
      title: Text(
        widget.text,
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff335f7e),
            fontWeight: FontWeight.bold),
      ),
      trailing: GestureDetector(
        onTap: () {
          onSwitchChange();
        },
        child: CustomSwitchButton(
          checked: widget.val,
          unCheckedColor: Colors.white,
          checkedColor: Colors.white,
          animationDuration: Duration(milliseconds: 200),
          backgroundColor: Color(0xff56c596),
        ),
      ),
    );
  }
}
