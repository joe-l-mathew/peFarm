import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/harvest/harvest_bloc.dart';
import '../../../constants/date.dart';
import '../../../constants/db_names.dart';
import '../../../models/harvest_model.dart';
import '../../../models/month_model.dart';
import '../../widgets/alert_dialouge.dart';

class ExpandableMonthTile extends StatelessWidget {
  const ExpandableMonthTile({
    Key? key,
    required this.reference,
    required this.model,
    required this.index,
  }) : super(key: key);

  final DocumentReference<Map<String, dynamic>> reference;
  final MonthModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: reference
            .collection(harvestCollection)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ExpansionTile(
                trailing: Text("${model.totalNos}"),
                collapsedBackgroundColor:
                    const Color.fromARGB(255, 243, 231, 227),
                backgroundColor: const Color.fromARGB(255, 243, 231, 227),
                initiallyExpanded: index == 0,
                title: Text(
                    "${dateNameList[model.date.month - 1]} ${model.date.year}"),
                children: List.generate(snapshot.data!.docs.length, (index) {
                  HarvestModel model =
                      HarvestModel.fromMap(snapshot.data!.docs[index].data());
                  return Card(
                    child: ListTile(
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
                                        context.read<HarvestBloc>().add(
                                            DeleteHarvest(
                                                reference: snapshot.data!
                                                    .docs[index].reference,
                                                nos: model.nos));
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK")),
                                ],
                              );
                            });
                      },
                      tileColor: const Color.fromARGB(255, 218, 233, 246),
                      trailing: Text("${model.nos.toInt()}"),
                      title: Text(
                          "${model.date.day}/${model.date.month}/${model.date.year}"),
                    ),
                  );
                }));
          } else {
            return const SizedBox();
          }
        });
  }
}
