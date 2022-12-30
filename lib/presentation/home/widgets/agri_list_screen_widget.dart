import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../constants/db_names.dart';
import '../../../models/agri_model.dart';
import '../../agri/agri_screen.dart';

class AgriListScreenWidget extends StatelessWidget {
  const AgriListScreenWidget({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final DocumentReference<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref
            .collection(agriCollection)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            return Expanded(
                child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // snapshot.data!.docs[index].reference;
                AgriModel agriModel =
                    AgriModel.fromMap(snapshot.data!.docs[index].data());
                DateTime date = agriModel.date;
                return ListTile(
                  onTap: () {
                    context.read<AgriScreenBloc>().add(AddReference(
                        reference: snapshot.data!.docs[index].reference));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AgriScreen()));
                  },
                  title: Text(agriModel.name),
                  subtitle: Text(
                      "Created on: ${date.day}/${date.month}/${date.year}"),
                  trailing: Text(
                      (agriModel.income - agriModel.expense).toString(),
                      style: TextStyle(
                          color: (agriModel.income - agriModel.expense) >= 0
                              ? Colors.green
                              : Colors.red)),
                );
              },
              physics: const BouncingScrollPhysics(),
            ));
          } else {
            return const Text("No data");
          }
        });
  }
}
