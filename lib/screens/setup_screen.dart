import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './tabs_screen.dart';
import '../providers/user_data.dart';
import '../widgets/input_field.dart';

class SetupScreen extends StatefulWidget {
  static const String routeName = '/setup';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _passObscure = true;
  bool _confirmObscure = true;
  TextEditingController _dateController = TextEditingController();
  DateTime _date = DateTime.now().subtract(Duration(days: 365 * 20 + 5));
  Map<String, String> _account = {
    'id': DateTime.now().toIso8601String(),
    'photo': '',
  };

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await Provider.of<UserData>(context, listen: false).signUp(_account);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                      label: 'Name',
                      textFormField: TextFormField(
                        decoration: InputDecoration(hintText: 'Your Name Here'),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _account['name'] = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name cannot be empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(
                          hintText: '********',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passObscure = !_passObscure;
                              });
                            },
                            child: Icon(_passObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: _passObscure,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Confirm Password',
                      textFormField: TextFormField(
                        decoration: InputDecoration(
                          hintText: '********',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmObscure = !_confirmObscure;
                              });
                            },
                            child: Icon(_confirmObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: _confirmObscure,
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
                        onFieldSubmitted: (_) => _pickDate(),
                        onSaved: (value) => _account['phone'] = value,
                        validator: (value) {
                          if (int.tryParse(value) == null) {
                            return 'Phone must contain numbers only!';
                          }
                          return null;
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
                            onSaved: (_) =>
                                _account['birth'] = _date.toIso8601String(),
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
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
