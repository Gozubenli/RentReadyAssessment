import 'package:rent_ready_assessment/Model/accountsController.dart';
import 'package:test/test.dart';

void main() {
  test('Searching accounts, result list contains accounts', () async {
    final controller = AccountsController();
    await controller.searchAccountList("");
    expect(controller.accountList.length, inInclusiveRange(1, 100));
  });

  test('Filter by stateCode', () async {
    final controller = AccountsController();
    await controller.searchAccountList("");
    await controller.filterByStateCode(0); //Active Accounts
    expect(controller.accountList.length, inInclusiveRange(1, 100));
  });

  test('Filter by stateOrProvince', () async {
    final controller = AccountsController();
    await controller.searchAccountList("");
    await controller.filterByStateOrProvince("NY"); //NY State
    print(controller.accountList.length);
    expect(controller.accountList.length, inInclusiveRange(0, 100));
  });
}
