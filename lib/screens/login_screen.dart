import 'package:expenses_tracker/screens/sign_up.dart';
import 'package:expenses_tracker/utils/app_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text('My Form'),
      ),
      body: Padding(
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
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
                  onPressed: _submitForm,
                  child: const Text(
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
