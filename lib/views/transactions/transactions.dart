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

  num avbalance = 0;

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
    getuser();
    gettotalexpense();
    gettotalincome();
    getexpenses();
    getincome();
  }

  Future<void> gettotalexpense() async {
    totalexpense = await helper.getTotalExpense();
    setState(() {
      avbalance = avbalance - totalexpense!;
    });
  }

  Future<void> gettotalincome() async {
    totalincome = await helper.getTotalIncome();
    setState(() {});
  }

  Future<void> getuser() async {
    user = await helper.getuser();
    setState(() {
      avbalance = user.first['budget'];
    });
  }

  Future<void> getexpenses() async {
    expenselist = await helper.getExpensesWithCategory();
    setState(() {});
  }

  Future<void> getincome() async {
    incomelist = await helper.getIncomes();
    setState(() {});
  }

  Future<void> deleteexpense(int id) async {
    await helper.deleteExpense(id);
  }

  Future<void> deleteincome(int id) async {
    await helper.deleteIncome(id);
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
          elevation: 0,
          title: Text(
            'transactions',
            style: GoogleFonts.inter(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),

        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (isloading) {
      return Center(child: CircularProgressIndicator());
    } else if (user.isEmpty || expenselist.isEmpty || incomelist.isEmpty) {
      return Center(
        child: Text("No data found", style: TextStyle(color: Colors.white)),
      );
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
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topRight,
                          end: AlignmentDirectional.bottomStart,
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
                            Colors.white60,
                          ],
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Balance",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '$avbalance',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        color: Colors.black,
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
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "₹$totalexpense",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topRight,
                          end: AlignmentDirectional.bottomStart,
                          colors: [
                            Colors.teal,
                            Colors.tealAccent,
                            Colors.white60,
                          ],
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Your Income",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹${user.first['income']}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Current total",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹$totalincome",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 15),

              selectedscreen == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'expenses',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: expenselist.length,
                          itemBuilder: (context, index) {
                            final expense = expenselist[index];
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Expense',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yMMMd().format(
                                              DateTime.parse(expense['date']),
                                            ),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        spacing: 10,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${expense['note']}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            spacing: 2,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '₹',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '${expense['amount']}',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          spacing: 20,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Text(
                                                  'cancel',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                deleteexpense(
                                                  expense['id'],
                                                ).then((value) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    expense;
                                                  });
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      255,
                                                      16,
                                                      16,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFFFFFF).withOpacity(0.25),
                                      Color(0xFFB3E5FC).withOpacity(0.1),
                                    ],
                                  ),
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade900,
                                          child: Icon(
                                            IconData(
                                              int.tryParse(
                                                    expense['category_icon'] ??
                                                        '0xf04b',
                                                  ) ??
                                                  0xf04b,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${expense['category_name']}',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${expense['note']}',
                                              style: const TextStyle(
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white54,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            '- ₹${expense['amount'].toString()}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'incomes',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: incomelist.length,
                          itemBuilder: (context, index) {
                            final income = incomelist[index];
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Income',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            '${income['date']}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        spacing: 10,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${income['source']}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            spacing: 2,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '₹',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '${income['amount']}',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          spacing: 20,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Text(
                                                  'cancel',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                deleteincome(income['id']).then(
                                                  (value) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      income;
                                                    });
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      255,
                                                      68,
                                                      68,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFFFFFF).withOpacity(0.25),
                                      Color(0xFFB3E5FC).withOpacity(0.1),
                                    ],
                                  ),
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade900,
                                          child: Icon(
                                            Icons.attach_money,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${income['source']}',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "${income['source']}",
                                              style: const TextStyle(
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white54,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            '+ ₹${income['amount']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
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
