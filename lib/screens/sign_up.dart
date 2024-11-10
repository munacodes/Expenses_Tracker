import 'package:expenses_tracker/screens/dashboard.dart';
import 'package:expenses_tracker/screens/login_screen.dart';
import 'package:expenses_tracker/service/auth_service.dart';
import 'package:expenses_tracker/utils/app_validator.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();
  var authService = AuthService();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        'username': _userNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'remainingAmount': 0,
        'totalCredit': 0,
        'totalDebit': 0,
      };
      await authService.createUser(data, context);

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
                  'Create new Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _userNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration(
                    'Username',
                    Icons.person,
                  ),
                  validator: appValidator.validateUserName,
                ),
                const SizedBox(height: 16),
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
                  controller: _phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration(
                    'Phone Number',
                    Icons.call,
                  ),
                  validator: appValidator.validatePhoneNumber,
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
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Create',
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
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Login',
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
