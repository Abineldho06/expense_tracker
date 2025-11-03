import 'package:expense_tracker/services/userservice.dart';
import 'package:expense_tracker/views/add_details/add_details.dart';
import 'package:expense_tracker/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:expense_tracker/views/signin_page/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  UserService userService = UserService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> islogined() async {
    if (await userService.islogined() == true) {
      if (await userService.isDetailsSaved() == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddDetailsScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: [
            const Color.fromARGB(255, 1, 79, 71),
            Color.fromARGB(255, 2, 71, 88),
            Color.fromARGB(255, 0, 28, 42),
            Color.fromARGB(255, 1, 29, 55),
            Color.fromARGB(255, 9, 0, 18),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/onboarding/onboarding_bg.png",
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      top: 100,
                      child: Image.asset(
                        "assets/images/onboarding/onboarding_image.png",
                        width: screenWidth * 1,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Positioned(
                      left: 50,
                      top: 100,
                      child: Image.asset(
                        "assets/images/onboarding/onboarding_icon.png",
                        width: screenWidth * 0.25,
                      ),
                    ),

                    Positioned(
                      right: 40,
                      top: 130,
                      child: Image.asset(
                        "assets/images/onboarding/onboarding_icon2.png",
                        width: screenWidth * 0.25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  "spend smarter\nsave more",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: InkWell(
                    onTap: () {
                      islogined();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff438883),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Log In",
                        style: GoogleFonts.inter(
                          color: Colors.teal,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
