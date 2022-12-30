import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/agri_screen/agri_screen_bloc.dart';
import '../../../constants/db_names.dart';
import '../../../models/month_model.dart';
import 'harvest_expandable_widget.dart';

class ExpandedHarvestList extends StatelessWidget {
  const ExpandedHarvestList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgriScreenBloc, AgriScreenState>(
      builder: (context, state) {
        return StreamBuilder(
            stream: state.reference!
                .collection(harvestCollection)
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentReference<Map<String, dynamic>> reference =
                          snapshot.data!.docs[index].reference;
                      MonthModel model =
                          MonthModel.fromMap(snapshot.data!.docs[index].data());
                      return ExpandableMonthTile(
                        reference: reference,
                        model: model,
                        index: index,
                      );
                    },
                  ),
                );
              }
              return const Text("Has no data");
            });
      },
    );
  }
}
