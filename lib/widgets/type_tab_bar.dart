import 'package:expenses_tracker/widgets/transectionList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TypeTabBar extends StatelessWidget {
  final String category;
  final String monthYear;
  const TypeTabBar(
      {super.key, required this.category, required this.monthYear});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'Credit',
                ),
                Tab(
                  text: 'Debit',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Transectionlist(
                    category: category,
                    type: 'Credit',
                    monthYear: monthYear,
                  ),
                  Transectionlist(
                    category: category,
                    type: 'Debit',
                    monthYear: monthYear,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
