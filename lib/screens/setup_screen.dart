import 'package:flutter/material.dart';

import './tabs_screen.dart';
import '../widgets/input_field.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/setup';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  TextEditingController _dateController = TextEditingController();
  DateTime _date = DateTime.now().subtract(Duration(days: 365 * 20 + 5));

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 80 + 20)),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 12 + 3)),
      helpText: 'SELECT YOUR DATE OF BIRTH',
    );
    if (picked != null) {
      _date = picked;
      _dateController.text = _date.toString().substring(0, 10);
    }
    setState(() {});
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: '********'),
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Confirm Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: '********'),
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Phone',
                      textFormField: TextFormField(
                        decoration: InputDecoration(
                          hintText: '01## ### ####',
                          counterText: '',
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        onFieldSubmitted: (_) {
                          _pickDate();
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _pickDate(),
                      child: AbsorbPointer(
                        child: InputField(
                          label: 'Date of Birth',
                          textFormField: TextFormField(
                            decoration: InputDecoration(hintText: 'YYYY-MM-DD'),
                            controller: _dateController,
                            onFieldSubmitted: (_) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: ElevatedButton(
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
