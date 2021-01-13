import 'package:flutter/material.dart';
import '../widgets/doctor_card.dart';
import '../models/clinic_schedule.dart';

class DataSearch extends SearchDelegate<String> {
  final hospitals = [
    'dar elfouad',
    'elnile',
    'elyasmeen',
    'aman',
    'elseoudi elalmani',
    'elkahraba'
  ];
  final recentHospitals = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //TODO:return this Doctor info here
    return DoctorCard(
      doctorName: 'Dr.Ahmed',
      hospitalName: 'Dar elfouad',
      schedule: [
        ClinicSchedule(day: 'Monday', time: '16:00-19:00'),
        ClinicSchedule(day: 'Monday', time: '16:00-19:00'),
        ClinicSchedule(day: 'Monday', time: '16:00-19:00')
      ],
      doctorSpecialty: 'ORTHODONTIC',
      examinationFee: 350,
      rating: 4,
      hospitalDistance: 30,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedHospitals = query.isEmpty
        ? recentHospitals
        : hospitals.where((p) => p.startsWith(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestedHospitals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: RichText(
              text: TextSpan(
                  text: suggestedHospitals[index].substring(0, query.length),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    TextSpan(
                        text: suggestedHospitals[index].substring(query.length),
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ]),
            ),
            onTap: () {
              query = suggestedHospitals[index];
              if (!recentHospitals.contains(query)) {
                recentHospitals.add(query);
              }

              showResults(context);
            },
          );
        });
  }
}
