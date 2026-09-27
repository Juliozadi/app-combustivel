import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_combustivel/main.dart';

void main() {
  test('Álcool compensa', () {
    Combustivel combustivel = Combustivel(3.50, 5.50);
    expect(combustivel.calcular(), 'Abasteça com Álcool');
  });

  test('Gasolina compensa', () {
    Combustivel combustivel = Combustivel(4.50, 5.50);
    expect(combustivel.calcular(), 'Abasteça com Gasolina');
  });

  test('Calcula a média', () {
    Combustivel combustivel = Combustivel(4, 6);
    expect(combustivel.calcularMedia(), 5);
  });

  testWidgets('Mostra a média na tela', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppCombustivel()));

    await tester.enterText(find.byType(TextField).at(0), '3.89');
    await tester.enterText(find.byType(TextField).at(1), '5.89');
    await tester.tap(find.text('Calcule a Média'));
    await tester.pump();

    expect(find.text('Média: R\$ 4.89'), findsOneWidget);
  });
}
