import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  TextEditingController sourcecontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  FocusNode sourcefNode = FocusNode();
  FocusNode amountfNode = FocusNode();
  FocusNode datefNode = FocusNode();

  final formkey = GlobalKey<FormState>();

  DateTime? _selecteddate;
  String? format;

  DatabaseHelper helper = DatabaseHelper();

  Future<void> selectdate() async {
    _selecteddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2060),
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
    if (_selecteddate != null) {
      format = DateFormat('dd-MM-yyyy').format(_selecteddate!);
      setState(() {
        datecontroller.text = format!;
      });
    }
  }

  Future<void> addincome() async {
    if (formkey.currentState!.validate() && datecontroller.text.isNotEmpty) {
      Income income = Income(
        source: sourcecontroller.text.trim(),
        amount: int.parse(amountcontroller.text.trim()),
        date: datecontroller.text.trim(),
      );

      helper.insertIncome(income).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Income Added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        sourcecontroller.clear();
        amountcontroller.clear();
        datecontroller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' Please fill every filed to submit'),
          backgroundColor: Colors.red,
        ),
      );
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
            'add income',
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
                child: Form(
                  key: formkey,
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
                        "Add your Income here!",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      textfield(
                        controller: sourcecontroller,
                        focusNode: sourcefNode,
                        labelText: 'amount source',
                        validator: (value) {
                          if (value == null) {
                            return 'please enter source amount';
                          } else if (value.isEmpty || value.length < 3) {
                            return 'please enter a valid source';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      textfield(
                        controller: amountcontroller,
                        focusNode: amountfNode,
                        labelText: 'amount',
                        validator: (value) {
                          if (value == null) {
                            return 'please enter amount';
                          } else if (value.isEmpty) {
                            return 'please enter a valid amount';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: datecontroller,
                        focusNode: datefNode,
                        style: TextStyle(color: Colors.white),
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white70,
                          ),
                          labelText: '',

                          labelStyle: TextStyle(color: Colors.white70),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onTap: () {
                          selectdate();
                        },
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: () {
                          addincome();
                        },
                        text: 'Submit',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
