import 'dart:io';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewExpense, {super.key});

  final void Function(Expense) addNewExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  _presentDatePicker() async {
    final now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('Please enter a valid title, amount and date'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ));
      return;
    }
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Invalid Input'),
              content:
                  const Text('Please enter a valid title, amount and date'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                )
              ],
            ));
  }

  void _submitExpData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog(context);
      return;
    }
    final newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.addNewExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                width >= 600
                    ? Row(children: [
                        Expanded(
                          child: TextField(
                            decoration:
                                const InputDecoration(label: Text('Title')),
                            maxLength: 50,
                            controller: _titleController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                              decoration: const InputDecoration(
                                label: Text('Amount'),
                                prefix: Text('€'),
                              ),
                              maxLength: 10,
                              controller: _amountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true)),
                        ),
                      ])
                    : TextField(
                        decoration: const InputDecoration(label: Text('Title')),
                        maxLength: 50,
                        controller: _titleController,
                      ),
                const SizedBox(height: 16),
                width >= 600
                    ? Row(
                        children: [
                          DropdownButton(
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Row(
                                        children: [
                                          Icon(categoryIcons[category]),
                                          const SizedBox(width: 8),
                                          Text(category.name.toUpperCase()),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value as Category;
                                });
                              },
                              value: _selectedCategory),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'No Date Chosen'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: _presentDatePicker,
                              )
                            ],
                          ))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextField(
                                decoration: const InputDecoration(
                                  label: Text('Amount'),
                                  prefix: Text('€'),
                                ),
                                maxLength: 10,
                                controller: _amountController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'No Date Chosen'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: _presentDatePicker,
                              )
                            ],
                          ))
                        ],
                      ),
                const SizedBox(height: 16),
                width >= 600
                    ? Row(
                        children: [
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                            onPressed: _submitExpData,
                            child: const Text('Add Expense'),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          DropdownButton(
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Row(
                                        children: [
                                          Icon(categoryIcons[category]),
                                          const SizedBox(width: 8),
                                          Text(category.name.toUpperCase()),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value as Category;
                                });
                              },
                              value: _selectedCategory),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                            onPressed: _submitExpData,
                            child: const Text('Add Expense'),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
