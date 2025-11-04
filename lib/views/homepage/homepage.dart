import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/views/add_expense/add_expense.dart';
import 'package:expense_tracker/views/add_income/add_income.dart';
import 'package:expense_tracker/views/category_adding/add_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper helper = DatabaseHelper();

  List<Map<String, dynamic>> user = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdetails();
  }

  Future<void> userdetails() async {
    await helper.initdb();
    user = await helper.getuser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 71, 88), // Deep violet at top
              Color.fromARGB(255, 0, 28, 42), // Rich indigo center
              Color.fromARGB(255, 1, 29, 55), // Rich indigo center
              Color.fromARGB(255, 9, 0, 18), // Subtle purple at bottom
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'home',
              style: GoogleFonts.inter(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  _container(),
                  SizedBox(height: 15),
                  lottiecontainer(context),
                  SizedBox(height: 5),
                  categoryAddContainer(),
                  SizedBox(height: 15),
                  expenseAddContainer(),
                  SizedBox(height: 15),
                  incomeAddContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget lottiecontainer(BuildContext context) {
    return Center(
      child: Container(
        child: Lottie.asset(
          repeat: false,
          'assets/json/lottie.json',
          width: MediaQuery.sizeOf(context).width * 1,
          height: MediaQuery.sizeOf(context).height * .27,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget categoryAddContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AddCategoryScreen();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    'Add Category',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Add your expense categories here.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white38,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget incomeAddContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AddIncomeScreen();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    'Add Income',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Keep track of all your earnings and sources.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white38,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseAddContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AddExpenseScreen();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    'Add Expense',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Keep track of all your spendings and expenses.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white38,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _container() {
    if (user.isEmpty) {
      return Center(child: Text("No Data Found"));
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topRight,
            end: AlignmentDirectional.bottomStart,
            colors: [Colors.teal, Colors.tealAccent, Colors.white60],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white60,
              offset: Offset(-2, 2),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                '  ${user.first['name']}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your budget',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      Row(children: [   
                        ],
                      ),
                      Text(
                        '  ₹${user.first['budget']}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Your income',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '₹${user.first['income']}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
