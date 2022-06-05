import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_ready_assessment/Model/accountsController.dart';

import '../Model/account.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Details")),
      backgroundColor: Colors.grey,
      body: Consumer<AccountsController>(
        builder: (context, model, child) {
          Account account = model.selectedAccount!;
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
              child: Card(
                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Center(
                  child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: AutoSizeText(account.name, maxLines: 2)),
                            Expanded(child: AutoSizeText(account.accountnumber)),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: AutoSizeText("StateCode: ${account.stateCode == 0 ? "Active" : "Inactive"}")),
                                Expanded(child: AutoSizeText("StateOrProvince: ${account.stateOrProvince}")),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
