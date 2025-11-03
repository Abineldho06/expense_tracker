import 'package:expense_tracker/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int? selectedscreen = 0;
  var user = [];

  List<Map<String, dynamic>> expenselist = [];
  List<Map<String, dynamic>> incomelist = [];

  bool isloading = false;

  num? totalexpense;
  num? totalincome;

  DatabaseHelper helper = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toggle();
    getalldetails();
    toggle();
  }

  void toggle() {
    setState(() {
      isloading = !isloading;
    });
  }

  void getalldetails() {
    gettotalexpense();
    gettotalincome();
    getuser();
    getexpenses();
    getincome();
  }

  Future<void> gettotalexpense() async {
    totalexpense = await helper.getTotalExpense();
    setState(() {});
  }

  Future<void> gettotalincome() async {
    totalincome = await helper.getTotalIncome();
    setState(() {});
  }

  Future<void> getuser() async {
    user = await helper.getuser();
    setState(() {});
  }

  Future<void> getexpenses() async {
    expenselist = await helper.getExpensesWithCategory();
    setState(() {});
  }

  Future<void> getincome() async {
    incomelist = await helper.getIncomes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Transactions',
            style: GoogleFonts.inter(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            CircleAvatar(radius: 20, backgroundColor: Colors.white),
            SizedBox(width: 15),
          ],
        ),

        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (isloading) {
      return Center(child: CircularProgressIndicator());
    } else if (user.isEmpty || expenselist.isEmpty || incomelist.isEmpty) {
      return Center(child: Text("No data found"));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedscreen = 0;
                      });
                    },

                    child: selectedscreen == 0
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              border: Border.all(color: Colors.white60),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            child: Text(
                              'Expense',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.white60),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            child: Text(
                              'Expense',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedscreen = 1;
                      });
                    },
                    child: selectedscreen == 1
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              border: Border.all(color: Colors.white60),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            child: Text(
                              'Income',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.white60),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            child: Text(
                              'Income',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              selectedscreen == 0
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70),
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentGeometry.bottomRight,
                          colors: [
                            Colors.teal.shade900,
                            Colors.teal.shade800,
                            Colors.teal.shade800,
                            Colors.teal.shade900,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade600,
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Your Budget",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹${user.first['budget']}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Your total expense",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹$totalexpense",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70),
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentGeometry.bottomRight,
                          colors: [
                            Colors.teal.shade900,
                            Colors.teal.shade800,
                            Colors.teal.shade800,
                            Colors.teal.shade900,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade600,
                            offset: Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Your Income",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹${user.first['income']}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Your total income",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹$totalincome",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: expenselist.length,
                itemBuilder: (context, index) {
                  final expense = expenselist[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                IconData(
                                  int.tryParse(
                                        expense['category_icon'] ?? '0xf04b',
                                      ) ??
                                      0xf04b,
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: Colors.teal,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${expense['category_name']}',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(
                                    DateTime.parse(expense['date']),
                                  ),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- ₹${expense['amount'].toString()}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 177, 2, 2),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
