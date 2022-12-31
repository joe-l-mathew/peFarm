import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/income/income_bloc.dart';
import '../../../constants/date.dart';
import '../../../constants/db_names.dart';
import '../../../models/income_model.dart';
import '../../../models/month_model.dart';
import '../../widgets/alert_dialouge.dart';
import '../../widgets/text_widget.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 100,
            width: width - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Color(0xff4338CA), Color(0xff6D28D9)])),
            child: Center(
              child: StreamBuilder(
                stream: context
                    .watch<AgriScreenBloc>()
                    .state
                    .reference!
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    var doc = snapshot.data!.data() as Map<String, dynamic>;
                    return TextWidget(
                      text: "TOTAL : ₹ ${doc['income']}",
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    );
                  }
                  return const TextWidget(
                    text: "TOTAL : 0",
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  );
                },
              ),
            ),
          ),
        ),
        StreamBuilder(
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
                            .limit(10)
                            .snapshots(),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData &&
                              snapshot1.data!.docs.length > 0) {
                            return ExpansionTile(
                                initiallyExpanded: index == 0,
                                title: Text(
                                    "${dateNameList[model.date.month - 1]} ${model.date.year}"),
                                children: List.generate(
                                    snapshot1.data!.docs.length, (index) {
                                  IncomeModel incomeModel = IncomeModel.fromMap(
                                      snapshot1.data!.docs[index].data());
                                  return ListTile(
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
                                                    child: Text("Cancel")),
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
                                                    child: Text("OK")),
                                              ],
                                            );
                                          });
                                    },
                                  );
                                }));
                          } else {
                            return SizedBox();
                          }
                        });
                  },
                ),
              );
            }
            return const LinearProgressIndicator();
          },
        )
      ],
    ));
  }
}
