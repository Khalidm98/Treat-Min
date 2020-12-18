import 'package:flutter/material.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class ModalSheetListTile extends StatefulWidget {
  final String text;
  final bool value;
  ModalSheetListTile({@required this.text, @required this.value});
  @override
  _ModalSheetListTileState createState() =>
      _ModalSheetListTileState(this.value);
}

class _ModalSheetListTileState extends State<ModalSheetListTile> {
  bool val;

  _ModalSheetListTileState(this.val);
  @override
  Widget build(BuildContext context) {
    void onSwitchChange() {
      setState(() {
        this.val = !this.val;
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
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 0),
              ) // changes position of shadow
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomSwitchButton(
            checked: this.val,
            unCheckedColor: Color(0xff56c596),
            checkedColor: Colors.white,
            animationDuration: Duration(milliseconds: 200),
            backgroundColor: this.val ? Color(0xff56c596) : Colors.white,
          ),
        ),
      ),
    );
  }
}
