import 'package:flutter/material.dart';

// import '../widgets/input_field.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/setup';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Setup Screen'));
  }
}
