import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/actions.dart';
import '../localizations/app_localizations.dart';
import '../models/card_data.dart';
import '../models/screens_data.dart';
import '../providers/provider_class.dart';
import '../utils/enumerations.dart';
import '../widgets/background_image.dart';
import '../widgets/clinic_card.dart';
import '../widgets/sor_card.dart';
import '../widgets/modal_sheet_list_tile.dart';

class AvailableScreen extends StatefulWidget {
  static const String routeName = '/available';

  @override
  _AvailableScreenState createState() => _AvailableScreenState();
}

class _AvailableScreenState extends State<AvailableScreen> {
  Future<String> response;
  //entities+detail lists
  ClinicCardData clinicData;
  SORCardData sorData;
  //search results
  List<ClinicCard> clinicCardsListFiltered = [];
  List<SORCard> sorCardsListFiltered = [];
  //rendered
  List<ClinicCard> clinicCardsList = [];
  List<SORCard> sorCardsList = [];
  final myController = TextEditingController();

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

  String removeWhitespace(String text) {
    return text.replaceAll(' ', '');
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

  noEntityDetails(ThemeData theme, AvailableScreenData selectScreenData) {
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
            style: theme.textTheme.headline6.copyWith(color: theme.accentColor),
          ),
        ),
      ]),
    );
  }

  @override
  void didChangeDependencies() {
    final selectScreenData =
        (ModalRoute.of(context).settings.arguments) as AvailableScreenData;
    response = ActionAPI.getEntityDetail(
        entityToString(selectScreenData.entity),
        selectScreenData.entityMap['id'].toString());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectScreenData =
        (ModalRoute.of(context).settings.arguments) as AvailableScreenData;
    setAppLocalization(context);

    onSearchTextChanged(String text) async {
      sorCardsListFiltered.clear();
      clinicCardsListFiltered.clear();
      text = removeWhitespace(text.toLowerCase());
      if (text.isEmpty) {
        setState(() {});
        return;
      }
      if (selectScreenData.entity == Entity.clinic) {
        clinicCardsList.forEach((clinicCard) {
          if (removeWhitespace(clinicCard.clinicCardData.price.toString())
                  .contains(text) ||
              removeWhitespace(clinicCard.clinicCardData.hospital.toLowerCase())
                  .contains(text) ||
              removeWhitespace(
                      clinicCard.clinicCardData.doctor.name.toLowerCase())
                  .contains(text) ||
              removeWhitespace(
                      clinicCard.clinicCardData.doctor.title.toLowerCase())
                  .contains(text)) {
            clinicCardsListFiltered.add(clinicCard);
          }
        });
        setState(() {});
      } else {
        sorCardsList.forEach((sorCard) {
          if (removeWhitespace(sorCard.sorCardData.price.toString())
                  .contains(text) ||
              removeWhitespace(sorCard.sorCardData.hospital.toLowerCase())
                  .contains(text)) {
            sorCardsListFiltered.add(sorCard);
          }
        });
        setState(() {});
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectScreenData.entityMap['name']),
        actions: [
          IconButton(
            icon: Image.asset("assets/icons/sort.png", width: 25, height: 25),
            onPressed: () {
              onSortClick(context, theme);
            },
          ),
        ],
      ),
      body: BackgroundImage(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          myController.clear();
                          onSearchTextChanged('');
                        },
                      )),
                  onChanged: onSearchTextChanged,
                ),
              ),
              FutureBuilder(
                future: response,
                builder: (_, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (response.data == "Something went wrong") {
                    return Center(
                      child: Text(
                        response.data,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headline6
                            .copyWith(color: theme.errorColor),
                      ),
                    );
                  }
                  if (response.hasData &&
                      selectScreenData.entity == Entity.clinic) {
                    clinicData = clinicCardFromJson(response.data);
                    if (clinicData.details.length == 0) {
                      return noEntityDetails(theme, selectScreenData);
                    }
                    clinicCardsList = clinicData.details
                        .asMap()
                        .entries
                        .map<ClinicCard>((detail) {
                      return ClinicCard(
                        entityId: selectScreenData.entityMap['id'],
                        entity: selectScreenData.entity,
                        clinicCardData: clinicData.details[detail.key],
                      );
                    }).toList();
                  }
                  if (response.hasData &&
                      selectScreenData.entity != Entity.clinic) {
                    sorData = sorCardFromJson(response.data);
                    if (sorData.details.length == 0) {
                      return noEntityDetails(theme, selectScreenData);
                    }
                    sorCardsList =
                        sorData.details.asMap().entries.map<SORCard>((detail) {
                      return SORCard(
                        entityId: selectScreenData.entityMap['id'],
                        entity: selectScreenData.entity,
                        sorCardData: sorData.details[detail.key],
                      );
                    }).toList();
                  }
                  return Expanded(
                    child: clinicCardsListFiltered.length != 0 ||
                            sorCardsListFiltered.length != 0 ||
                            myController.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: selectScreenData.entity == Entity.clinic
                                ? clinicCardsListFiltered.length
                                : sorCardsListFiltered.length,
                            itemBuilder: (context, index) {
                              return selectScreenData.entity == Entity.clinic
                                  ? clinicListSorter(
                                      context, clinicCardsListFiltered)[index]
                                  : sorListSorter(
                                      context, sorCardsListFiltered)[index];
                            },
                          )
                        : ListView.builder(
                            itemCount: selectScreenData.entity == Entity.clinic
                                ? clinicCardsList.length
                                : sorCardsList.length,
                            itemBuilder: (context, index) {
                              return selectScreenData.entity == Entity.clinic
                                  ? clinicListSorter(
                                      context, clinicCardsList)[index]
                                  : sorListSorter(context, sorCardsList)[index];
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
