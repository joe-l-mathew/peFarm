import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/income/income_bloc.dart';
import '../../../constants/date.dart';
import '../../../constants/db_names.dart';
import '../../../models/income_model.dart';
import '../../../models/month_model.dart';
import '../../widgets/alert_dialouge.dart';

class IncomeListWidget extends StatefulWidget {
  IncomeListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomeListWidget> createState() => _IncomeListWidgetState();
  int limit = 10;
}

class _IncomeListWidgetState extends State<IncomeListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context
          .watch<AgriScreenBloc>()
          .state
          .reference!
          .collection(incomeCollection)
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                DateModel model =
                    DateModel.fromMap(snapshot.data!.docs[index].data());
                return StreamBuilder(
                    stream: context
                        .watch<AgriScreenBloc>()
                        .state
                        .reference!
                        .collection(incomeCollection)
                        .doc("${model.date.year}${model.date.month}")
                        .collection(incomeCollection)
                        .orderBy('date', descending: true)
                        .limit(widget.limit)
                        .snapshots(),
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData &&
                          snapshot1.data!.docs.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 2, left: 2, right: 2),
                          child: ExpansionTile(
                              textColor: Colors.black,
                              collapsedBackgroundColor:
                                  const Color.fromARGB(255, 219, 218, 218),
                              backgroundColor:
                                  const Color.fromARGB(255, 225, 241, 226),
                              initiallyExpanded: index == 0,
                              trailing: Text(model.amount.toString()),
                              title: Text(
                                  "${dateNameList[model.date.month - 1]} ${model.date.year}"),
                              children: List.generate(
                                  snapshot1.data!.docs.length + 1, (index) {
                                if (index == snapshot1.data!.docs.length) {
                                  return TextButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.limit += 10;
                                        });
                                      },
                                      child: Text("SHOW MORE"));
                                }
                                IncomeModel incomeModel = IncomeModel.fromMap(
                                    snapshot1.data!.docs[index].data());
                                return Card(
                                  child: ListTile(
                                    tileColor: const Color.fromARGB(
                                        255, 187, 217, 241),
                                    title: Text(incomeModel.title),
                                    subtitle: Text(
                                        "${incomeModel.date.day}/${incomeModel.date.month}/${incomeModel.date.year}"),
                                    trailing: Text("₹ ${incomeModel.amount}"),
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
                                                    child:
                                                        const Text("Cancel")),
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      context
                                                          .read<IncomeBloc>()
                                                          .add(DeleteIncome(
                                                              reference:
                                                                  snapshot1
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference,
                                                              amount:
                                                                  incomeModel
                                                                      .amount));
                                                    },
                                                    child: const Text("OK")),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                );
                              })),
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
              },
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}
