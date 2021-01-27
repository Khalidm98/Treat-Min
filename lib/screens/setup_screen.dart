import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/widgets/translated_text.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

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
  TextEditingController _dateController = TextEditingController();
  DateTime _date = DateTime.now().subtract(Duration(days: 365 * 20 + 5));
  int _gender = 0;
  File _image;
  Map<String, String> _account = {
    'id': DateTime.now().toIso8601String(),
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
    if (_image == null) {
      _account['photo'] = '';
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/account.photo';
      imageCache.clear();
      await _image.copy(path);
      _account['photo'] = path;
    }
    await Provider.of<UserData>(context, listen: false).signUp(_account);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
      setState(() {
        _dateController.text = _date.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: TranslatedText(
                  jsonKey: 'Account Setup',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline4,
                ),
              ),
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.accentColor, width: 2),
                      image: DecorationImage(
                        image: _image == null
                            ? AssetImage('assets/images/placeholder.png')
                            : FileImage(_image),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100, left: 100),
                    child: CircleAvatar(
                      backgroundColor: theme.accentColor,
                      radius: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                      label: 'Name',
                      textFormField: TextFormField(
                        decoration: InputDecoration(
                            hintText: translator.currentLanguage == 'en'
                                ? 'Your Name Here'
                                : 'اسمك هنا'),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _account['name'] = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return translator.currentLanguage == 'en'
                                ? 'Name cannot be empty!'
                                : 'الاسم لا يمكن ان يكون فارغ!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    InputField(
                      label: 'Phone',
                      textFormField: TextFormField(
                        decoration: InputDecoration(
                          hintText: translator.currentLanguage == 'en'
                              ? '01## ### ####'
                              : '#### ### 01##',
                          counterText: '',
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        onSaved: (value) => _account['phone'] = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return translator.currentLanguage == 'en'
                                ? 'Phone cannot be empty!'
                                : 'رقم الهاتف لا يمكن ان يكون فارغ!';
                          } else if (int.tryParse(value) == null) {
                            return translator.currentLanguage == 'en'
                                ? 'Phone must contain numbers only!'
                                : 'رقم الهاتف يجب ان يحتوي على ارقام فقط!';
                          } else if (value.length != 11) {
                            return translator.currentLanguage == 'en'
                                ? 'Phone must contain exactly 11 numbers!'
                                : 'رقم الهاتف يجب ان يحتوي على 11 رقم!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _pickDate();
                      },
                      child: AbsorbPointer(
                        child: InputField(
                          label: 'Date of Birth',
                          textFormField: TextFormField(
                            decoration: InputDecoration(hintText: 'YYYY-MM-DD'),
                            controller: _dateController,
                            onSaved: (_) =>
                                _account['birth'] = _date.toIso8601String(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return translator.currentLanguage == 'en'
                                    ? 'Date of birth cannot be empty!'
                                    : 'تاريخ الميلاد لا يمكن ان يكون فارغ!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  TranslatedText(
                      jsonKey: 'Gender:', style: theme.textTheme.subtitle1),
                  Spacer(),
                  Radio(
                    value: 1,
                    groupValue: _gender,
                    onChanged: (value) => setState(() => _gender = value),
                    activeColor: theme.primaryColorDark,
                  ),
                  TranslatedText(
                      jsonKey: 'Male', style: theme.textTheme.subtitle1),
                  Spacer(),
                  Radio(
                    value: 2,
                    groupValue: _gender,
                    onChanged: (value) => setState(() => _gender = value),
                    activeColor: theme.primaryColorDark,
                  ),
                  TranslatedText(
                      jsonKey: 'Female', style: theme.textTheme.subtitle1),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
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
