import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rent_ready_assessment/Model/account.dart';
import 'package:rent_ready_assessment/Model/accountsController.dart';

class AccountItem extends StatelessWidget {
  final Account account;
  const AccountItem({
    required this.account,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          leading: const FlutterLogo(),
          title: Text(account.name),
          subtitle: Text(account.name),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class FilterPanel extends StatelessWidget {
  const FilterPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AccountsController>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          DropdownButton<String>(
            value: model.stateCodeList[0],
            icon: const Icon(Icons.arrow_drop_down),
            //elevation: 16,
            onChanged: (String? newValue) {},
            items: model.stateCodeList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: model.stateOrProvinceList[0],
            icon: const Icon(Icons.arrow_drop_down),
            //elevation: 16,
            onChanged: (String? newValue) {},
            items: model.stateOrProvinceList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    const spinkit = SpinKitWave(
      color: Colors.amber,
      size: 50.0,
    );
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: Consumer<AccountsController>(
            builder: (context, model, child) {
              return RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  await model.searchAccountList(searchController.text);
                  return;
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: false,
                              controller: searchController,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              onSubmitted: (s) {
                                if (s.length > 1) {
                                  model.searchAccountList(s);
                                }
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "Search",
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await model.clickFilterPanel();
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                              Icon(Icons.filter_alt),
                              Text("Filter"),
                            ]),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.view_list_sharp),
                                tooltip: 'Filter',
                                onPressed: () {
                                  model.setList();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.grid_view_sharp),
                                tooltip: 'Filter',
                                onPressed: () {
                                  model.setGrid();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (model.isFilterPanelVisible)
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: FilterPanel(),
                      ),
                    model.isloading
                        ? const Expanded(child: spinkit)
                        : Expanded(
                            child: model.isList
                                ? ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: model.accountList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return AccountItem(account: model.accountList[index]);
                                    })
                                : GridView.builder(
                                    padding: const EdgeInsets.all(8),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: model.accountList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return AccountItem(account: model.accountList[index]);
                                    }),
                          ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
