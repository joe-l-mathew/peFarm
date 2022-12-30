import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../bloc/harvest/harvest_bloc.dart';
import '../../../functions/show_snackbar.dart';
import '../../widgets/loading_button_widget.dart';

class AddHarvestScreen extends StatelessWidget {
  const AddHarvestScreen({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "ADD YOUR HARVEST",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter Nos or KG"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HarvestBloc, HarvestState>(
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
                    context.read<HarvestBloc>().add(SetCompletedToFalse());
                    // ignore: use_build_context_synchronously
                    context.read<HarvestBloc>().add(ChangeDate(date: newDate));
                  }
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        BlocListener<HarvestBloc, HarvestState>(
          listener: (context, state) {
            print("is completed:${state.isCompleted}");
            print("is failed:${state.isFailed}");
            if (state.isFailed == true || state.isCompleted == true) {
              Navigator.pop(context);
              controller.clear();
              if (state.isFailed) {
                showSnackbar(context, "Some Error Occured");
              }
              if (state.isCompleted == true) {
                showSnackbar(context, "Added Successfully");
              }
            }
          },
          child: const Spacer(),
        ),
        BlocBuilder<HarvestBloc, HarvestState>(
          builder: (context, state) {
            return BlocBuilder<AgriScreenBloc, AgriScreenState>(
              builder: (context, stateAgri) {
                return LoadingButtonWidget(
                    text: "ADD",
                    loadingText: "ADDING..",
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<HarvestBloc>().add(AddHarvest(
                          nos: double.parse(controller.text),
                          reference: stateAgri.reference!));
                    });
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
