import 'package:expense_tracker/services/userservice.dart';
import 'package:expense_tracker/views/add_details/add_details.dart';
import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:expense_tracker/views/signup_page/signup_page.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode emailfocusNode = FocusNode();
  FocusNode passfocusNode = FocusNode();

  UserService userService = UserService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      userService.saveuser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddDetailsScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logged in successfully!')));
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
            Color.fromARGB(255, 2, 71, 88), // Deep violet at top
            Color.fromARGB(255, 0, 28, 42), // Rich indigo center
            Color.fromARGB(255, 1, 29, 55), // Rich indigo center
            Color.fromARGB(255, 9, 0, 18), // Subtle purple at bottom
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Hi! Welcome back, you have been missed.",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    textfield(
                      controller: _emailController,
                      focusNode: emailfocusNode,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        } else if (!value.contains('@')) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password Field
                    textfield(
                      controller: _passwordController,
                      focusNode: passfocusNode,
                      labelText: 'password',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    CustomButton(
                      onPressed: () {
                        _validateAndSubmit();
                      },
                      text: 'Sign in',
                    ),

                    const SizedBox(height: 30),

                    // Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or sign in with",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Social Icons
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

                    // Sign up text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignUpScreen()),
                            );
                          },
                          child: const Text(
                            "Sign up",
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
