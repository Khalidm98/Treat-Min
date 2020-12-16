import 'package:flutter/material.dart';

import '../widgets/input_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/setup';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  FocusNode _passNode = FocusNode();
  TextEditingController dateController=TextEditingController();

  DateTime date = DateTime(DateTime.now().year - 20);

  Future<void> _pickDate() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 80),
      lastDate: DateTime(DateTime.now().year - 10),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.greenAccent,
              onPrimary: Colors.black,
              surface: Colors.greenAccent,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },

    );
    if (pickedDate != null) {
      date = pickedDate;
      dateController.text= date.toString().substring(0, 10);
      setState(() {

      });
      // str = _dateOfBirth.toString().substring(0, 10);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Setup your Account')),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: SafeArea(
                child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: <Widget>[
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 3,
                  selectedColor: Colors.greenAccent,
                  unselectedColor: Colors.blueGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InputField(
                    label: 'Phone Number',
                    hintText: '+02xxxxxxx',
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (_) {
                      _passNode.requestFocus();
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InputField(
                        label: 'Date of birth',
                        hintText: 'day:month:year',
                        controller: dateController,
                        onFieldSubmitted: (_) => _passNode.requestFocus(),
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _pickDate();
                        })),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InputField(
                    label: 'Address',
                    hintText: 'area,streetno.,buildingno,',
                    keyboardType: TextInputType.streetAddress,
                    onFieldSubmitted: (_) {
                      _passNode.requestFocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InputField(
                    label: 'Working at ',
                    hintText: 'Company name ',
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (_) {
                      _passNode.requestFocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InputField(
                    label: 'Position',
                    hintText: 'JUNIOR ENGINEER ',
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (_) {
                      _passNode.requestFocus();
                    },
                  ),
                ),
              ]),
            ),
          ),
        ))));
  }
}
