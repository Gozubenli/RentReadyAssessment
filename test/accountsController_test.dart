import 'package:rent_ready_assessment/Model/accountsController.dart';
import 'package:test/test.dart';

void main() {
  test('Searching accounts, result list contains accounts', () async {
    final controller = AccountsController();

    await controller.searchAccountList("");

    expect(controller.accountList.length, 3);
  });
}
