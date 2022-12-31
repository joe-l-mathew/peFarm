import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/expense/expense_bloc.dart';
import '../../../constants/date.dart';
import '../../../constants/db_names.dart';
import '../../../models/date_model.dart';
import '../../../models/expense_model.dart';
import '../../widgets/alert_dialouge.dart';

class ExpenseListWidget extends StatefulWidget {
  ExpenseListWidget({super.key});

  @override
  State<ExpenseListWidget> createState() => _ExpenseListWidgetState();
  int limit = 10;
}

class _ExpenseListWidgetState extends State<ExpenseListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context
          .watch<AgriScreenBloc>()
          .state
          .reference!
          .collection(expenseCollection)
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
                        .collection(expenseCollection)
                        .doc("${model.date.year}${model.date.month}")
                        .collection(expenseCollection)
                        .orderBy('date', descending: true)
                        .limit(widget.limit)
                        .snapshots(),
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData &&
                          snapshot1.data!.docs.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: ExpansionTile(
                              trailing: Text(snapshot.data!.docs[index]
                                  .data()['amount']
                                  .toString()),
                              // trailing:
                              textColor: Colors.black,
                              collapsedBackgroundColor:
                                  const Color.fromARGB(255, 219, 218, 218),
                              backgroundColor:
                                  const Color.fromARGB(255, 243, 167, 161),
                              initiallyExpanded: index == 0,
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
                                      child: const Text("SHOW MORE"));
                                }
                                ExpenseModel expenseModel =
                                    ExpenseModel.fromMap(
                                        snapshot1.data!.docs[index].data());

                                return Card(
                                  child: ListTile(
                                    tileColor: const Color.fromARGB(
                                        255, 218, 233, 246),
                                    title: Text(expenseModel.title),
                                    subtitle: Text(
                                        "${expenseModel.date.day}/${expenseModel.date.month}/${expenseModel.date.year}"),
                                    trailing: Text("₹ ${expenseModel.amount}"),
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
                                                      Navigator.pop(context);
                                                      context
                                                          .read<ExpenseBloc>()
                                                          .add(DeleteExpense(
                                                              reference:
                                                                  snapshot1
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference,
                                                              amount:
                                                                  expenseModel
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
