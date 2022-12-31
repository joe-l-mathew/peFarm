import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/agri_screen/agri_screen_bloc.dart';
import 'screens/expense_screen.dart';
import 'screens/harvest_screen.dart';
import 'screens/income_screen.dart';
import 'widgets/add_expense_screen.dart';
import 'widgets/add_harvest_screen.dart';
import 'widgets/add_income_screen.dart';

class AgriScreen extends StatelessWidget {
  AgriScreen({super.key});
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Harvest"),
    BottomNavigationBarItem(icon: Icon(Icons.download), label: "Income"),
    BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Expense")
  ];
  List<Widget> screens = const [
    HarvestScreen(),
    IncomeScreen(),
    ExpenseScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final amountController = TextEditingController();
    final titleController = TextEditingController();

    return BlocBuilder<AgriScreenBloc, AgriScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.pageIndex,
            items: bottomItem,
            onTap: (value) {
              context
                  .read<AgriScreenBloc>()
                  .add(AddBottomIndex(bottomIndex: value));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state.pageIndex == 0) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (builder) {
                      return AddHarvestScreen(
                        controller: controller,
                      );
                    });
              }
              if (state.pageIndex == 1) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (builder) {
                      return AddIncomeScreen(
                        incomeController: amountController,
                        titleController: titleController,
                      );
                    });
              }
              if (state.pageIndex == 2) {
                
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (builder) {
                      return AddExpenseScreen(
                        incomeController: amountController,
                        titleController: titleController,
                      );
                    });
              }
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
