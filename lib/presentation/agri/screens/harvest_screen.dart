import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';
import '../widgets/harvest_list_widget.dart';

class HarvestScreen extends StatelessWidget {
  const HarvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
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
                  child: TextWidget(
                    text: "TOTAL : 1000",
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const ExpandedHarvestList()
          ],
        ),
      ),
    );
  }
}
