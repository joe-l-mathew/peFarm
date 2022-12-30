import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCursolTile extends StatelessWidget {
  const HomeCursolTile({
    Key? key,
    required this.width,
    required this.heading,
    required this.income,
    required this.expense,
    required this.balance,
  }) : super(key: key);

  final double width;
  final String heading;
  final String income;
  final String expense;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: width - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xff4338CA), Color(0xff6D28D9)])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              heading,
              style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "INCOME: ₹ $income",
              style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "EXPENSE: ₹ $expense",
              style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "BALANCE: ₹ $balance",
              style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
