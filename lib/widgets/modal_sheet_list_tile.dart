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
            checked: widget.val,
            unCheckedColor: Color(0xff56c596),
            checkedColor: Colors.white,
            animationDuration: Duration(milliseconds: 200),
            backgroundColor: widget.val ? Color(0xff56c596) : Colors.white,
          ),
        ),
      ),
    );
  }
}
