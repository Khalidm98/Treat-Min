import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localizations/app_localizations.dart';
import '../widgets/background_image.dart';

class ContactUsScreen extends StatelessWidget {
  static const String routeName = '/contact_us';

  static const treatMinEmail = "noreply@treat-min.com";
  static const khalidEmail = "khalid.refaat98@gmail.com";
  static const ahmedEmail = "ahmedkhaled11119999@gmail.com";
  static const url = 'https://www.facebook.com/Treatmin';

  _openURL() async {
    await launch(url);
  }

  _launchEmail(String email) async {
    await launch("mailto:$email");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    return Scaffold(
      appBar: AppBar(title: Text(t('contact_us'))),
      body: BackgroundImage(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return;
          },
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.indigo[600],
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/facebook.png',
                    height: 35,
                    width: 40,
                  ),
                  title: Text(
                    t('visit_us'),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: _openURL,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.cyan[500],
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ListTile(
                  leading: const Icon(Icons.alternate_email, size: 40),
                  title: Text(
                    t("send_us_email"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "noreply@treat-min.com",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _launchEmail(treatMinEmail);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/dev_clean.png',
                    height: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    t("developers"),
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Image.asset(
                    'assets/icons/dev.png',
                    height: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchEmail(ahmedEmail);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: theme.primaryColorDark,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/ahmed.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t("ahmed_name"),
                            style: theme.textTheme.subtitle1
                                .copyWith(fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: theme.primaryColorLight,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                ahmedEmail,
                                style: theme.textTheme.subtitle1.copyWith(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchEmail(khalidEmail);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: theme.primaryColorDark,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/khalid.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t("khalid_name"),
                            style: theme.textTheme.subtitle1
                                .copyWith(fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: theme.primaryColorLight,
                              ),
                              SizedBox(width: 10),
                              Text(
                                khalidEmail,
                                style: theme.textTheme.subtitle1.copyWith(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
