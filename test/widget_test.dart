import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rent_ready_assessment/Model/accountsController.dart';
import 'package:rent_ready_assessment/main.dart';

void main() {
  testWidgets('Widget Tests', (WidgetTester tester) async {
    final controller = AccountsController();
    await tester.pumpWidget(
      ChangeNotifierProvider<AccountsController>(
        child: const MyApp(),
        create: (context) => controller,
      ),
    );
    //Search Account
    await tester.enterText(find.byKey(const Key('search')), 'adven');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('adven'), findsOneWidget);
  });
}
