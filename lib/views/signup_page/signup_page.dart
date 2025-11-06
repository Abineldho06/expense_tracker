import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:expense_tracker/views/signin_page/signin_page.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  FocusNode fnamefocusnode = FocusNode();
  FocusNode lnamefocusnode = FocusNode();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passfocusnode = FocusNode();

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 108, 5, 132),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 46, 3, 56),
              Color.fromARGB(255, 59, 1, 72),
              Color.fromARGB(255, 50, 3, 60),
              Color.fromARGB(255, 0, 0, 0), // Rich indigo center
              Color.fromARGB(255, 9, 0, 18), // Subtle purple at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Create your new account",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: textfield(
                            controller: _firstName,
                            focusNode: fnamefocusnode,
                            labelText: 'First name',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter first name'
                                : null,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: textfield(
                            controller: _lastName,
                            focusNode: lnamefocusnode,
                            labelText: 'Last name',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter last name'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Email
                    textfield(
                      controller: _email,
                      focusNode: emailfocusnode,
                      labelText: 'email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        } else if (!value.contains('@')) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Password
                    textfield(
                      controller: _password,
                      focusNode: passfocusnode,
                      labelText: 'password',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    CustomButton(
                      onPressed: () {
                        _validateAndSubmit();
                      },
                      text: 'Sign up',
                    ),

                    SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or sign up with",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          "assets/images/signin&signup/Google.png",
                        ),

                        const SizedBox(width: 20),
                        _buildSocialButton(
                          "assets/images/signin&signup/Linkedin.png",
                        ),

                        const SizedBox(width: 20),
                        _buildSocialButton(
                          "assets/images/signin&signup/apple.png",
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "If you have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => SignInScreen()),
                            );
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ],
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

  Widget _buildSocialButton(String path) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade200,
      child: Image.asset(path, width: 22),
    );
  }
}
