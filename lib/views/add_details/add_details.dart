import 'dart:ffi';

import 'package:expense_tracker/core/constants/image_constants.dart';
import 'package:expense_tracker/models/user.dart';
import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/services/userservice.dart';
import 'package:expense_tracker/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:expense_tracker/views/homepage/homepage.dart';
import 'package:flutter/material.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final formkey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController incomecontroller = TextEditingController();

  FocusNode namefocusNode = FocusNode();
  FocusNode emailfocusNode = FocusNode();
  FocusNode budgetfocusNode = FocusNode();
  FocusNode incomefocusNode = FocusNode();

  DatabaseHelper helper = DatabaseHelper();
  UserService userService = UserService();

  Future<void> saveuserdetails() async {
    if (formkey.currentState!.validate()) {
      User user = User(
        name: namecontroller.text.trim(),
        email: emailcontroller.text.trim(),
        budget: int.parse(budgetcontroller.text.trim()),
        income: int.parse(incomecontroller.text.trim()),
      );
      await helper.insertUser(user).then((value) {
        userService.saveDetails();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details Added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        namecontroller.clear();
        emailcontroller.clear();
        budgetcontroller.clear();
        incomecontroller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details Added successfully!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
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
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Container(
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(190),
                        ),
                        image: DecorationImage(
                          image: AssetImage(ImageConstants.appbarring),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Text(
                            'Add Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          textfield(
                            controller: namecontroller,
                            focusNode: namefocusNode,
                            labelText: 'user name',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter User Name';
                              } else if (value.length < 3) {
                                return 'User Name must contain morethan 3 character';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          textfield(
                            controller: emailcontroller,
                            focusNode: emailfocusNode,
                            labelText: 'email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter email';
                                } else if (!value.contains('@')) {
                                  return 'Enter valid email';
                                }
                                return null;
                              };
                            },
                          ),
                          const SizedBox(height: 16),
                          textfield(
                            controller: incomecontroller,
                            focusNode: incomefocusNode,
                            labelText: 'income',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter income';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          textfield(
                            controller: budgetcontroller,
                            focusNode: budgetfocusNode,
                            labelText: 'budget',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter budget';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            onPressed: () {
                              saveuserdetails();
                            },
                            text: 'submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
