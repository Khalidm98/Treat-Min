import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/localizations/app_localization.dart';
import 'package:treat_min/main.dart';

import './get_started_screen.dart';
import './tabs_screen.dart';
import '../providers/app_data.dart';
import '../providers/user_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;
  Animation<double> _width;

  void _expand() => setState(() {});

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_width == null) {
      _width = Tween(begin: 0.0, end: MediaQuery.of(context).size.width * 0.8)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
      _width.addListener(_expand);
      _controller.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () async {
          final appData = Provider.of<AppData>(context, listen: false);
          if (await appData.isFirstRun()) {
            await appData
                .setLanguage(AppLocalization.of(context).locale.languageCode);
            Navigator.of(context)
                .pushReplacementNamed(GetStartedScreen.routeName);
          } else {
            MyApp.setLocale(context, Locale(await appData.getLanguage()));
            await Provider.of<UserData>(context, listen: false).tryAutoLogIn();
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _width.removeListener(_expand);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: Container(
            width: _width.value,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
