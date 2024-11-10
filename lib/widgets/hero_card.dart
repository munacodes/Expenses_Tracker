import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final String userId;
  HeroCard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Document does not exist'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Cards(data: data);
      },
    );
  }
}

class Cards extends StatelessWidget {
  final Map data;
  const Cards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'N',
                      style: TextStyle(
                        fontSize: 44,
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${data['remainingAmount']}',
                      style: TextStyle(
                        fontSize: 44,
                        color: data['remainingAmount'] > 0
                            ? Colors.white
                            : Colors.red,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CardOne(
                  color: Colors.green,
                  heading: 'Credit',
                  amount: '${data['totalCredit']}',
                ),
                SizedBox(width: 10),
                CardOne(
                  color: Colors.red,
                  heading: 'Debit',
                  amount: '${data['totalDebit']}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  final Color color;
  final String heading;
  final String amount;
  const CardOne({
    super.key,
    required this.color,
    required this.heading,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(color: color, fontSize: 14),
                  ),
                  Text(
                    'N ${amount}',
                    style: TextStyle(
                        color: color,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  heading == 'Credit'
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
