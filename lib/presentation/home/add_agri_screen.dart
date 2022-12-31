import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/agri/agri_bloc.dart';
import '../../functions/show_snackbar.dart';
import '../widgets/loading_button_widget.dart';

class AddAgriScreen extends StatelessWidget {
  const AddAgriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _farmController = TextEditingController();
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "ADD YOUR FARM",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autofocus: true,
              controller: _farmController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter a name for farm"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocListener<AgriBloc, AgriState>(
            listener: (context, state) {
              if (state.isCompleted == true) {
                Navigator.pop(context);
                showSnackbar(
                    context, "Farm ${_farmController.text} Added Successfully");
              }
              // TODO: implement listener
            },
            child: const Spacer(),
          ),
          BlocBuilder<AgriBloc, AgriState>(
            builder: (context, state) {
              return LoadingButtonWidget(
                  text: "ADD",
                  loadingText: "ADDING...",
                  isLoading: state.isLoading,
                  onPressed: () {
                    if (_farmController.text.isNotEmpty) {
                      context
                          .read<AgriBloc>()
                          .add(AddAgri(agriName: _farmController.text));
                    } else {
                      showSnackbar(context, "PLEASE ENTER A NAME");
                      Navigator.pop(context);
                    }
                  });
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
