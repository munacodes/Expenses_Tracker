import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/utils/app_validator.dart';
import 'package:expenses_tracker/widgets/category_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var amountController = TextEditingController();
  var titleController = TextEditingController();

  var appValidator = AppValidator();
  var isLoader = false;
  var uid = Uuid();

  var type = 'credit';
  var category = 'Others';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      var amount = int.parse(amountController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MM y').format(date);

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if (type == 'credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit -= amount;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'remainingAmount': remainingAmount,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'updatedAt': timestamp,
      });

      var data = {
        'id': id,
        'title': titleController.text,
        'amount': amount,
        'type': type,
        'timestamp': timestamp,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'remainingAmount': remainingAmount,
        'monthyear': monthyear,
        'category': category,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .doc(id)
          .set(data);

      // await authService.loginUser(data, context);

      Navigator.pop(context);

      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: amountController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            CategoryDropdown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
              value: 'credit',
              items: [
                DropdownMenuItem(
                  child: Text('Credit'),
                  value: 'credit',
                ),
                DropdownMenuItem(
                  child: Text('Debit'),
                  value: 'debit',
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (isLoader == false) {
                  _submitForm();
                }
              },
              child: isLoader
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
