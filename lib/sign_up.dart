import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  MyForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully'),
        ),
      );
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 11) {
      return 'Please enter a 11-digit phone number';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }

    return null;
  }

  String? _validateUserName(value) {
    if (value!.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              const Text(
                'Create new Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration(
                  'Username',
                  Icons.person,
                ),
                validator: _validateUserName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: _buildInputDecoration(
                  'Email',
                  Icons.email,
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                decoration: _buildInputDecoration(
                  'Phone Number',
                  Icons.call,
                ),
                validator: _validatePhoneNumber,
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(
                  'Password',
                  Icons.lock,
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
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
