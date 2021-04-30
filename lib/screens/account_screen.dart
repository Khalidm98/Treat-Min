import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/api/actions.dart';
import 'package:treat_min/models/reservations.dart';
import '../utils/enumerations.dart';
import './auth_screen.dart';
import './info_screen.dart';
import '../localizations/app_localizations.dart';
import '../providers/user_data.dart';
import '../widgets/reservation_card.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool expansionListChanger = false;
  Future appointmentsResponse;
  String cancellationResponse;
  Entity entity = Entity.clinic;
  List<ReservedEntityDetails> current;
  List<ReservedEntityDetails> history;

  noReservation(ThemeData theme) {
    return Card(
      margin: EdgeInsets.all(0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        trailing: Icon(
          Icons.book,
          color: theme.accentColor,
        ),
        title: Text(
          getText('no_reservations'),
          style:
              theme.textTheme.subtitle2.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    appointmentsResponse = ActionAPI.getUserAppointments(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    final userData = Provider.of<UserData>(context);
    setAppLocalization(context);

    return SafeArea(
      child: userData.isLoggedIn
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.accentColor, width: 2),
                    image: DecorationImage(
                      image: userData.photo.isEmpty
                          ? AssetImage('assets/images/placeholder.png')
                          : FileImage(File(userData.photo)),
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.of(context).pushNamed(InfoScreen.routeName);
                    },
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.account_circle, color: accent, size: 40),
                  title: Text(getText('name')),
                  subtitle: Text(userData.name),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.date_range, color: accent, size: 40),
                  title: Text(getText('birth')),
                  subtitle: Text(userData.birth.toString().substring(0, 10)),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.phone_android, color: accent, size: 40),
                  title: Text(getText('phone')),
                  subtitle: Text(userData.phone),
                ),
                Divider(height: 0),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    getText('reservations'),
                    style: theme.textTheme.headline5,
                  ),
                ),
                FutureBuilder(
                    future: appointmentsResponse,
                    builder: (_, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            Spacer(),
                            CircularProgressIndicator(),
                            Spacer()
                          ],
                        );
                      }
                      if (response.data == "Something went wrong") {
                        return Card(child: Text("Something went wrong"));
                      }
                      Reservations reservedAppointments =
                          reservationsFromJson(response.data);
                      current = reservedAppointments.current.clinics +
                          reservedAppointments.current.rooms +
                          reservedAppointments.current.services;

                      return current.length != 0
                          ? ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: current.length,
                              itemBuilder: (_, index) {
                                return ReservationCard(
                                    reservedEntityDetails: current[index],
                                    isCurrentRes: true,
                                    entity: current[index].clinic != null
                                        ? Entity.clinic
                                        : current[index].service != null
                                            ? Entity.service
                                            : Entity.room,
                                    appointmentId: current[index].id,
                                    onCancel: () {
                                      setState(() {
                                        didChangeDependencies();
                                      });
                                    });
                              })
                          : noReservation(theme);
                    }),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    getText('history_reservations'),
                    style: theme.textTheme.headline5,
                  ),
                ),
                FutureBuilder(
                    future: appointmentsResponse,
                    builder: (_, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            Spacer(),
                            CircularProgressIndicator(),
                            Spacer()
                          ],
                        );
                      }
                      if (response.data == "Something went wrong") {
                        return Card(child: Text("Something went wrong"));
                      }
                      Reservations reservedAppointments =
                          reservationsFromJson(response.data);
                      history = reservedAppointments.past.clinics +
                          reservedAppointments.past.rooms +
                          reservedAppointments.past.services;
                      return history.length != 0
                          ? ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: history.length,
                              itemBuilder: (_, index) {
                                return ReservationCard(
                                  reservedEntityDetails: history[index],
                                  isCurrentRes: false,
                                  entity: history[index].clinic != null
                                      ? Entity.clinic
                                      : history[index].service != null
                                          ? Entity.service
                                          : Entity.room,
                                  entityId: history[index].clinicId != null
                                      ? history[index].clinicId
                                      : history[index].serviceId != null
                                          ? history[index].serviceId
                                          : history[index].roomId,
                                  entityDetailId: history[index]
                                              .clinicDetailId !=
                                          null
                                      ? history[index].clinicDetailId
                                      : history[index].serviceDetailId != null
                                          ? history[index].serviceDetailId
                                          : history[index].roomDetailId,
                                );
                              })
                          : noReservation(theme);
                    }),
                SizedBox(height: 15)
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 50),
                Text(
                  getText('not_logged_in'),
                  style: theme.textTheme.headline5,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    child: Text(getText('log_in')),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
