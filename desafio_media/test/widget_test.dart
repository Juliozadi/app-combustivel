import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:desafio_media/main.dart';

void main() {
  testWidgets('Calcula a média dos valores', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppMedia()));

    await tester.enterText(find.byType(TextField).at(0), '7');
    await tester.enterText(find.byType(TextField).at(1), '8');
    await tester.enterText(find.byType(TextField).at(2), '10');
    await tester.tap(find.text('Calcule a Média'));
    await tester.pump();

    expect(find.text('A média é 8.33'), findsOneWidget);
  });
}
