import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_data.dart';
import '../localizations/app_localizations.dart';
import '../providers/provider_class.dart';
import '../utils/search_bar.dart';
import '../utils/enumerations.dart';
import '../widgets/clinic_card.dart';
import '../widgets/sor_card.dart';
import '../models/screens_data.dart';
import '../widgets/modal_sheet_list_tile.dart';
import '../api/actions.dart';

class AvailableScreen extends StatelessWidget {
  static const String routeName = '/available';

  void onSortClick(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                color: theme.primaryColorLight,
                alignment: Alignment.center,
                child: Text(
                  getText('sort'),
                  style: theme.textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ModalSheetListTile(
                text: getText('price_low'),
                value: Provider.of<ProviderClass>(context).sortingVars[0],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceLowHigh,
              ),
              ModalSheetListTile(
                text: getText('price_high'),
                value: Provider.of<ProviderClass>(context).sortingVars[1],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceHighLow,
              ),
              // ModalSheetListTile(
              //   text: getText('nearest'),
              //   value: Provider.of<ProviderClass>(context).sortingVars[2],
              //   onSwitchChange:
              //       Provider.of<ProviderClass>(context).changeSortNearest,
              // ),
            ],
          ),
        );
      },
    );
  }

  List<ClinicCard> clinicListSorter(
      BuildContext context, List<ClinicCard> entityDetailsList) {
    if (Provider.of<ProviderClass>(context).sortingVars[0] == true) {
      entityDetailsList.sort(
          (a, b) => a.clinicCardData.price.compareTo(b.clinicCardData.price));
      return entityDetailsList;
    } else if (Provider.of<ProviderClass>(context).sortingVars[1] == true) {
      entityDetailsList.sort(
          (a, b) => a.clinicCardData.price.compareTo(b.clinicCardData.price));
      return entityDetailsList.reversed.toList();
    } else {
      return entityDetailsList;
    }
  }

  List<SORCard> sorListSorter(
      BuildContext context, List<SORCard> entityDetailsList) {
    if (Provider.of<ProviderClass>(context).sortingVars[0] == true) {
      entityDetailsList
          .sort((a, b) => a.sorCardData.price.compareTo(b.sorCardData.price));
      return entityDetailsList;
    } else if (Provider.of<ProviderClass>(context).sortingVars[1] == true) {
      entityDetailsList
          .sort((a, b) => a.sorCardData.price.compareTo(b.sorCardData.price));
      return entityDetailsList.reversed.toList();
    } else {
      return entityDetailsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<ClinicCard> clinicDetailsList = [];
    List<SORCard> sorDetailsList = [];

    final selectScreenData =
        (ModalRoute.of(context).settings.arguments) as AvailableScreenData;

    Future getDetails() async {
      String jsonResponse = await ActionAPI.getEntityDetail(
          entityToString(selectScreenData.entity),
          selectScreenData.entityMap['id'].toString());
      if (jsonResponse == "Something went wrong") {
        return jsonResponse;
      }
      if (selectScreenData.entity == Entity.clinic) {
        return clinicCardFromJson(jsonResponse);
      } else {
        return sorCardFromJson(jsonResponse);
      }
    }

    setAppLocalization(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(selectScreenData.entityMap['name']),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
            IconButton(
              icon: Image.asset("assets/icons/sort.png", width: 25, height: 25),
              onPressed: () {
                onSortClick(context, theme);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: getDetails(),
          builder: (_, response) {
            if (response.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (response.data is String) {
              return Center(
                child: Text(
                  response.data,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline6
                      .copyWith(color: theme.errorColor),
                ),
              );
            }
            if (response.hasData && response.data.details.length == 0) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      "assets/images/doctor_sad.png",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Unfortunately, No ${entityToString(selectScreenData.entity)} are"
                      " available in this section for now. Please check again later!",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline6
                          .copyWith(color: theme.accentColor),
                    ),
                  ),
                ]),
              );
            }
            if (response.hasData && selectScreenData.entity == Entity.clinic) {
              clinicDetailsList = response.data.details
                  .asMap()
                  .entries
                  .map<ClinicCard>((detail) {
                return ClinicCard(
                  clinicCardData: response.data.details[detail.key],
                );
              }).toList();
            } else if (response.hasData &&
                (selectScreenData.entity == Entity.room ||
                    selectScreenData.entity == Entity.service)) {
              sorDetailsList =
                  response.data.details.asMap().entries.map<SORCard>((detail) {
                return SORCard(
                  sorCardData: response.data.details[detail.key],
                );
              }).toList();
            }
            return ListView.builder(
                itemCount: selectScreenData.entity == Entity.clinic
                    ? clinicDetailsList.length
                    : sorDetailsList.length,
                itemBuilder: (context, index) {
                  return selectScreenData.entity == Entity.clinic
                      ? clinicListSorter(context, clinicDetailsList)[index]
                      : sorListSorter(context, sorDetailsList)[index];
                });
          },
        ));
  }
}
