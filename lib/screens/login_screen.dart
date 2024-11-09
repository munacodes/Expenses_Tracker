import 'package:expenses_tracker/screens/dashboard.dart';
import 'package:expenses_tracker/screens/sign_up.dart';
import 'package:expenses_tracker/service/auth_service.dart';
import 'package:expenses_tracker/utils/app_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();
  var authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var isLoader = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      await authService.loginUser(data, context);

      setState(() {
        isLoader = false;
      });

      // ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
      //   const SnackBar(
      //     content: Text('Form submitted successfully'),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'Login Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(
                    'Email',
                    Icons.email,
                  ),
                  validator: appValidator.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: _buildInputDecoration(
                    'Password',
                    Icons.lock,
                  ),
                  validator: appValidator.validatePassword,
                ),
                const SizedBox(height: 40),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      isLoader ? print('Loading') : _submitForm();
                    },
                    child: isLoader
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpView();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Create new Account',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      labelText: label,
      suffixIcon: Icon(suffixIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
