import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'account.dart';

class AccountsController extends ChangeNotifier {
  List<Account> _accountListAll = [];
  List<Account> _accountList = [];
  bool _isloading = false;
  bool _isList = true;
  bool _isFilterPanelVisible = false;

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

  List<String> get stateCodeList {
    List<String> list = [];
    groupBy(_accountList, (Account obj) => obj.stateCode).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  List<String> get stateOrProvinceList {
    List<String> list = [];
    groupBy(_accountList, (Account obj) => obj.stateOrProvince).forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  Future<void> clickFilterPanel() async {
    _isFilterPanelVisible = !_isFilterPanelVisible;
    notifyListeners();
  }

  Future<void> filterByStateCode(String filterText) async {
    _accountList = _accountListAll.where((account) => account.stateCode.toLowerCase().contains(filterText.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> filterByStateOrProvince(String filterText) async {
    _accountList = _accountListAll.where((account) => account.stateOrProvince.toLowerCase().contains(filterText.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> searchAccountList(String searchText) async {
    ///TODO Search API
    _isloading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _accountListAll = [
      Account(name: "name1", stateCode: "stateCode1", stateOrProvince: "stateOrProvince1"),
      Account(name: "name2", stateCode: "stateCode2", stateOrProvince: "stateOrProvince2"),
      Account(name: "name3", stateCode: "stateCode3", stateOrProvince: "stateOrProvince3"),
    ];
    _accountList = _accountListAll;
    _isloading = false;
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
