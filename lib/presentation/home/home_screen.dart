import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/db_names.dart';
import '../widgets/text_widget.dart';
import 'add_agri_screen.dart';
import 'widgets/agri_list_screen_widget.dart';
import 'widgets/carousel_slider_widget.dart';
import 'widgets/cursol_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var ref = FirebaseFirestore.instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid);
    List<Widget> coursalItems = [
      //year
      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Year")
            .snapshots(),
        builder: (context, snapshot) {
          return HomeCursolTile(
            width: width,
            heading: "heading",
            income: '50000',
            expense: '30000',
            balance: '20000',
          );
        },
      ),
      //Total Home Page Tile
      StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeCursolTile(
                  width: width,
                  heading: "TOTAL",
                  income: snapshot.data!['income'].toString(),
                  expense: snapshot.data!['expense'].toString(),
                  balance:
                      (snapshot.data!['income'] - snapshot.data!['expense'])
                          .toString());
            } else {
              return HomeCursolTile(
                  width: width,
                  heading: "TOTAL",
                  income: "0.0",
                  expense: "expense",
                  balance: "balance");
            }
          }),
      HomeCursolTile(
          width: width,
          heading: "2022",
          income: "income",
          expense: "expense",
          balance: "balance"),
    ];
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection(userCollection).snapshots(),
          builder: (context, snapshot) {
            return SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: TextWidget(text: "Welcome Back", fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CarouselSliderWidget(coursalItems: coursalItems),
                ),
                AgriListScreenWidget(ref: ref),
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return const AddAgriScreen();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
