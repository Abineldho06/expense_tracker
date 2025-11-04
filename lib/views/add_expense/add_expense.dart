import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _noteFocus = FocusNode();

  final DatabaseHelper dbHelper = DatabaseHelper();

  List<Category> _categories = [];
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      List<Map<String, dynamic>> categoryMaps = await dbHelper.getCategories();
      setState(() {
        _categories = categoryMaps
            .map(
              (map) =>
                  Category(id: map['id'], name: map['name'], icon: map['icon']),
            )
            .toList();
      });
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.teal,
            onPrimary: Colors.white,
            surface: Color(0xFF0A1828),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _insertExpense() async {
    if (_selectedCategory == null ||
        _amountController.text.isEmpty ||
        double.tryParse(_amountController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields properly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final expense = Expense(
      categoryId: _selectedCategory!.id!,
      amount: double.parse(_amountController.text),
      note: _noteController.text.trim(),
      date: _selectedDate.toIso8601String(),
    );

    try {
      await dbHelper.insertExpense(expense);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _amountController.clear();
      _noteController.clear();
    } catch (e) {
      print('Error inserting expense: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 2, 71, 88),
            Color.fromARGB(255, 0, 28, 42),
            Color.fromARGB(255, 1, 29, 55),
            Color.fromARGB(255, 9, 0, 18),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.white),
          title: Text(
            'add expense',
            style: GoogleFonts.inter(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 40,
                  top: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF).withOpacity(0.25),
                      Color(0xFFB3E5FC).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Add your Expense here!",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Category Dropdown
                    DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      dropdownColor: Colors.grey[900],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.2),
                      ),
                      hint: const Text(
                        'Select Category',
                        style: TextStyle(color: Colors.white70),
                      ),
                      iconEnabledColor: Colors.white70,
                      items: _categories.map((cat) {
                        return DropdownMenuItem<Category>(
                          value: cat,
                          child: Row(
                            children: [
                              Icon(
                                IconData(
                                  int.tryParse(cat.icon ?? '0xf04b') ?? 0xf04b,
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cat.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Amount field
                    textfield(
                      controller: _amountController,
                      focusNode: _amountFocus,
                      labelText: 'Amount',
                      keyboardType: TextInputType.number,
                      validator: (_) {},
                    ),
                    const SizedBox(height: 20),

                    // Note field
                    textfield(
                      controller: _noteController,
                      focusNode: _noteFocus,
                      labelText: 'Note (optional)',
                      keyboardType: TextInputType.text,
                      validator: (_) {},
                    ),
                    const SizedBox(height: 20),

                    // Date picker
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white70),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Add button
                    CustomButton(
                      onPressed: _insertExpense,
                      text: 'Add Expense',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
