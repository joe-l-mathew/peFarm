import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../widgets/text_widget.dart';
import '../widgets/expense_list_widget.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

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
                      text: "TOTAL : ₹ ${doc['expense']}",
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
        SizedBox(
          height: 10,
        ),
        ExpenseListWidget()
      ],
    ));
  }
}
