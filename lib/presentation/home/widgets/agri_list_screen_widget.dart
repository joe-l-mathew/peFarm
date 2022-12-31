import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri/agri_bloc.dart';
import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../constants/db_names.dart';
import '../../../models/agri_model.dart';
import '../../agri/agri_screen.dart';
import '../../widgets/alert_dialouge.dart';

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
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(),
                  Text("NO DATA FOUND")
                ],
              );
            }

            return Expanded(
                child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // snapshot.data!.docs[index].reference;
                AgriModel agriModel =
                    AgriModel.fromMap(snapshot.data!.docs[index].data());
                DateTime date = agriModel.date;
                return ListTile(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialogWidget(
                            title: "Do you want to delete",
                            description:
                                "Are you sure you want to delete this FARM",
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    context.read<AgriBloc>().add(DeleteAgri(
                                        reference: snapshot
                                            .data!.docs[index].reference));
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK")),
                            ],
                          );
                        });
                  },
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
