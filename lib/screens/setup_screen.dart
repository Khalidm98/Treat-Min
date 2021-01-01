import 'package:flutter/material.dart';

import './tabs_screen.dart';
import '../widgets/input_field.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/setup';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  List<FocusNode> _focusNodes = List();
  TextEditingController _dateController = TextEditingController();
  DateTime _date = DateTime.now().subtract(Duration(days: 365 * 20 + 5));

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 80 + 20)),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 12 + 3)),
    );
    if (picked != null) {
      _date = picked;
      _dateController.text = _date.toString().substring(0, 10);
    } else {
      _dateController.text = '';
    }
    setState(() {});
    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Account Setup',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                      label: 'Name',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: 'Your Name Here'),
                        textCapitalization: TextCapitalization.words,
                        onFieldSubmitted: (_) {
                          _focusNodes[0].requestFocus();
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: '********'),
                        focusNode: _focusNodes[0],
                        obscureText: true,
                        onFieldSubmitted: (_) {
                          _focusNodes[1].requestFocus();
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Confirm Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: '********'),
                        focusNode: _focusNodes[1],
                        obscureText: true,
                        onFieldSubmitted: (_) {
                          _focusNodes[2].requestFocus();
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Phone',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: '01## ### ####'),
                        focusNode: _focusNodes[2],
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Date of Birth',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: 'YYYY-MM-DD'),
                        controller: _dateController,
                        onTap: () {
                          _pickDate();
                          // _pickDate().then((_) {
                          //   FocusScope.of(context).unfocus();
                          // });
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: RaisedButton(
                  child: Text('Finish'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        TabsScreen.routeName, (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
