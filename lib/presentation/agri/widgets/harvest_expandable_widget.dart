import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/harvest/harvest_bloc.dart';
import '../../../constants/date.dart';
import '../../../constants/db_names.dart';
import '../../../models/harvest_model.dart';
import '../../../models/month_model.dart';
import '../../widgets/alert_dialouge.dart';

class ExpandableMonthTile extends StatefulWidget {
  ExpandableMonthTile({
    Key? key,
    required this.reference,
    required this.model,
    required this.index,
  }) : super(key: key);

  final DocumentReference<Map<String, dynamic>> reference;
  final MonthModel model;
  final int index;

  @override
  State<ExpandableMonthTile> createState() => _ExpandableMonthTileState();
  int limit = 10;
}

class _ExpandableMonthTileState extends State<ExpandableMonthTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.reference
            .collection(harvestCollection)
            .orderBy('date', descending: true)
            .limit(widget.limit)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: ExpansionTile(
                  trailing: Text("${widget.model.totalNos}"),
                  textColor: Colors.black,
                  collapsedBackgroundColor: const Color.fromARGB(255, 219, 218, 218),
                  backgroundColor: const Color.fromARGB(255, 166, 166, 246),
                  initiallyExpanded: widget.index == 0,
                  title: Text(
                      "${dateNameList[widget.model.date.month - 1]} ${widget.model.date.year}"),
                  children:
                      List.generate(snapshot.data!.docs.length + 1, (index) {
                    if (index == snapshot.data!.docs.length) {
                      return TextButton(
                          onPressed: () {
                            setState(() {
                              widget.limit += 10;
                            });
                          },
                          child: const Text("SHOW MORE"));
                    } else {
                      HarvestModel model = HarvestModel.fromMap(
                          snapshot.data!.docs[index].data());
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
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () async {
                                            context.read<HarvestBloc>().add(
                                                DeleteHarvest(
                                                    reference: snapshot.data!
                                                        .docs[index].reference,
                                                    nos: model.nos));
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK")),
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
                    }
                  })),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
