import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:rent_ready_assessment/Service/accountService.dart';

import 'account.dart';

class AccountsController extends ChangeNotifier {
  List<Account> _accountListAll = [];
  List<Account> _accountList = [];
  Account? _selectedAccount;
  bool _isloading = false;
  bool _isList = true;
  bool _isFilterPanelVisible = false;
  int? _selectedStateCode;
  String? _selectedStateOrProvince;

  List<Account> get accountList {
    return _accountList;
  }

  bool get isFilterPanelVisible {
    return _isFilterPanelVisible;
  }

  bool get isList {
    return _isList;
  }

  bool get isloading {
    return _isloading;
  }

  Account? get selectedAccount {
    return _selectedAccount;
  }

  int? get selectedStateCode {
    return _selectedStateCode;
  }

  String? get selectedStateOrProvince {
    return _selectedStateOrProvince;
  }

  List<int> get stateCodeList {
    List<int> list = [];
    groupBy(_accountListAll, (Account obj) => obj.stateCode).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  List<String> get stateOrProvinceList {
    List<String> list = [];
    groupBy(_accountListAll, (Account obj) => obj.stateOrProvince).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  Future<void> clickFilterPanel() async {
    _isFilterPanelVisible = !_isFilterPanelVisible;
    notifyListeners();
  }

  Future<void> filterByStateCode(int filter) async {
    _selectedStateCode = filter;
    _accountList = _accountListAll.where((account) => account.stateCode == filter).toList();
    notifyListeners();
  }

  Future<void> filterByStateOrProvince(String filterText) async {
    _selectedStateOrProvince = filterText;
    _accountList = _accountListAll.where((account) => account.stateOrProvince.toLowerCase().contains(filterText.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> searchAccountList(String searchText) async {
    ///TODO Search API
    _isloading = true;
    notifyListeners();

    _accountListAll = await AccountService.getAccountList(searchText);
    // await Future.delayed(const Duration(seconds: 2));
    // _accountListAll = [
    //   Account(name: "name1", stateCode: "stateCode1", stateOrProvince: "stateOrProvince1"),
    //   Account(name: "name2", stateCode: "stateCode2", stateOrProvince: "stateOrProvince2"),
    //   Account(name: "name3", stateCode: "stateCode3", stateOrProvince: "stateOrProvince3"),
    // ];
    _accountList = _accountListAll;
    _isloading = false;
    notifyListeners();
  }

  Future<void> selectAccount(Account account) async {
    _selectedAccount = account;
    notifyListeners();
  }

  Future<void> setGrid() async {
    _isList = false;
    notifyListeners();
  }

  Future<void> setList() async {
    _isList = true;
    notifyListeners();
  }
}
