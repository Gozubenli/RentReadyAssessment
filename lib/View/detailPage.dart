import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_ready_assessment/Model/accountsController.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsController>(
      builder: (context, cart, child) {
        return const Text('Detail');
      },
    );
  }
}
