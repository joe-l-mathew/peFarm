import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/income/income_bloc.dart';
import '../../../functions/show_snackbar.dart';
import '../../../models/income_model.dart';
import '../../widgets/loading_button_widget.dart';

class AddIncomeScreen extends StatelessWidget {
  AddIncomeScreen(
      {super.key,
      required this.incomeController,
      required this.titleController});
  final TextEditingController incomeController;

  final TextEditingController titleController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "ADD INCOME",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: incomeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Amount"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Title"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<IncomeBloc, IncomeState>(
              builder: (context, state) {
                return Text(
                  "${state.date.day}/${state.date.month}/${state.date.year}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                );
              },
            ),
            IconButton(
                onPressed: () async {
                  final DateTime? newDate = await showDatePicker(
                    // initialEntryMode: DatePickerEntryMode.calendar,
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2017, 1),
                    lastDate: DateTime.now(),
                    helpText: 'Select a date',
                  );
                  if (newDate != null) {
                    // ignore: use_build_context_synchronously
                    context.read<IncomeBloc>().add(UpdateDate(date: newDate));
                  }
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        Spacer(),
        BlocBuilder<AgriScreenBloc, AgriScreenState>(
          builder: (context, agriState) {
            return BlocBuilder<IncomeBloc, IncomeState>(
              builder: (context, state) {
                return LoadingButtonWidget(
                    text: "ADD",
                    loadingText: "ADDING",
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (incomeController.text.isNotEmpty &&
                          titleController.text.isNotEmpty) {
                        context.read<IncomeBloc>().add(AddIncome(
                            model: IncomeModel(
                                amount: double.parse(incomeController.text),
                                title: titleController.text,
                                date: state.date),
                            reference: agriState.reference!));
                      } else {
                        Navigator.pop(context);
                        showSnackbar(context, "Please Fill All Fields");
                      }
                    });
              },
            );
          },
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
