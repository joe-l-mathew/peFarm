import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/expense/expense_bloc.dart';
import '../../../functions/show_snackbar.dart';
import '../../../models/expense_model.dart';
import '../../widgets/loading_button_widget.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen(
      {super.key,
      required this.incomeController,
      required this.titleController});
  final TextEditingController incomeController;

  final TextEditingController titleController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "ADD EXPENSE",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: incomeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Amount"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Title"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ExpenseBloc, ExpenseState>(
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
                    context.read<ExpenseBloc>().add(UpdateDate(date: newDate));
                  }
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        const Spacer(),
        BlocBuilder<AgriScreenBloc, AgriScreenState>(
          builder: (context, agriState) {
            return BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                return LoadingButtonWidget(
                    text: "ADD",
                    loadingText: "ADDING",
                    isLoading: state.isLoading,
                    onPressed: () {
                      try {
                        double.parse(incomeController.text);
                        if (incomeController.text.isNotEmpty &&
                            titleController.text.isNotEmpty) {
                          Navigator.pop(context);
                          context.read<ExpenseBloc>().add(AddExpense(
                              model: ExpenseModel(
                                  amount: double.parse(incomeController.text),
                                  title: titleController.text,
                                  date: state.date),
                              reference: agriState.reference!));
                          incomeController.clear();
                          titleController.clear();
                        } else {
                          Navigator.pop(context);
                          showSnackbar(context, "Please Fill All Fields");
                        }
                      } catch (e) {
                        incomeController.clear();
                        titleController.clear();
                        Navigator.pop(context);
                        showSnackbar(context, "Invalid Input");
                      }
                    });
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
