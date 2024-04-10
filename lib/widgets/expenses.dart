import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Train ticket',
      amount: 30.0,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Movie ticket',
      amount: 15.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Laptop',
      amount: 1000.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
        title: 'Flutter course',
        amount: 50.0,
        date: DateTime.now(),
        category: Category.work),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
