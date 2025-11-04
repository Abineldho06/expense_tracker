import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/services/userservice.dart';
import 'package:expense_tracker/views/signin_page/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseHelper helper = DatabaseHelper();
  UserService userService = UserService();

  List<Map<String, dynamic>> user = [];

  num? totalexpense;
  num? totalincome;

  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    getincomeexpensetotal();
  }

  void toggle() {
    setState(() {
      isloading = !isloading;
    });
  }

  Future<void> getuser() async {
    await helper.initdb();
    user = await helper.getuser();
    setState(() {});
  }

  Future<void> getincomeexpensetotal() async {
    await helper.initdb();
    totalexpense = await helper.getTotalExpense();
    totalincome = await helper.getTotalIncome();
    setState(() {});
  }

  void signout() {
    userService.logout();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'profile',
            style: GoogleFonts.montserrat(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.horizontal(
                      start: Radius.circular(10),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * .28,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  Text(
                                    "Manage Profiles",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  Text(
                                    "App Settings",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.person_outline_outlined,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  Text(
                                    "Account",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.help_outline,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  Text(
                                    "Help",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                signout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.exit_to_app_outlined,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  Text(
                                    "Sign out",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.settings, color: Colors.white, size: 30),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: body(),
      ),
    );
  }

  Widget body() {
    if (isloading) {
      return Center(child: CircularProgressIndicator());
    } else if (user.isEmpty) {
      return Center(child: Text('No Data'));
    } else {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.teal, Colors.tealAccent, Colors.white60],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpeg'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${user.first['name']}',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${user.first['email']}',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Container(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
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
                ),
                SizedBox(height: 20),

                Container(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 20,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total expense',
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
                                  '  ₹$totalexpense',
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
                                  'Current total Income',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '₹$totalincome',
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
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'progress',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          container(
                            label: 'expense',
                            amount: '₹$totalexpense',
                            progress: .7,
                            color: Colors.orangeAccent,
                          ),
                          container(
                            label: 'income',
                            amount: '₹$totalincome',
                            progress: 0.2,
                            color: Colors.lightBlueAccent,
                          ),
                          container(
                            label: 'total',
                            amount: 'average',
                            progress: 0.4,
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget container({
    required String amount,
    required String label,
    required double progress,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 25,
            width: 25,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 7,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
                Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
