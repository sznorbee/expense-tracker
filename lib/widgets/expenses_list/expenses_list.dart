import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDeleteExpense});

  final List<Expense> expenses;
  final void Function(Expense) onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: const Icon(Icons.delete, color: Colors.white, size: 40),
            ),
            onDismissed: (direction) => onDeleteExpense(expenses[index]),
            child: ExpenseItem(expenses[index])));
  }
}
